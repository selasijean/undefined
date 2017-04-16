//
//  Location.swift
//  undefined
//
//  Created by Selasi Jean Kwame Adedze on 2/8/17.
//  Copyright © 2017 Jean Adedze. All rights reserved.
//

import UIKit
import GoogleMaps
import Parse
class Location: NSObject {
    
//    var cell:LocationTableViewCell?
    var currentLocationCoords: CLLocation!
    var parseObject: PFObject!{
        didSet{
            name = parseObject["name"] as? String
            if let placeid = parseObject["place_id"] as? String{
                placeID = placeid
//                getETA()
            }
            placeID = parseObject["place_id"] as? String
            if let usersCon = parseObject["usersconnected"] as? [String: [String]]{
                usersConnectedWithETA = usersCon
            }
//            usersConnectedWithETA = parseObject["usersconnected"] as? [String: [String]]
        }
    }
    var usersConnectedWithETA: [String : [String]] = [:]
    var coordinates: CLLocationCoordinate2D?
    var name: String?
    var address: String?
    var placeID: String?
    var eta: String = "..."
    
    init(pfObject: PFObject){
        super.init()
        ({self.parseObject = pfObject})()
    }
    
    func getETA(completion: @escaping () -> ()) {
        
        let latitude = String(describing: currentLocationCoords.coordinate.latitude)
        let longitude = String(describing: currentLocationCoords.coordinate.longitude)
        let destString = "=place_id:" + "\((placeID)!)"
        let path = ("https://maps.googleapis.com/maps/api/distancematrix/json?origins=" + "\(latitude)," + "\(longitude)" + "&destinations" + "\(destString)" + "&key=AIzaSyC3DeaKs0Dg4iipA-N2bfu0qJyvkJAtc9g").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        
        let urlString = URL(string: path!)
        let config = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: config)
        
        
        if let url = urlString {
            let task = urlSession.dataTask(with: url, completionHandler: { (data:Data?, response: URLResponse?, error: Error?) in
                if error != nil {
                    print(error?.localizedDescription)
                    
                } else {
                    if let usableData = data {
                        let json = try? JSONSerialization.jsonObject(with: usableData, options: []) as! NSDictionary
                        let rows = json!["rows"] as? [NSDictionary]
                        print(rows)
                        if let first = rows?.first{
                            let firstElement = first["elements"] as? [NSDictionary]
                            if let duration = firstElement?.first!["duration"] as? NSDictionary{
                                if let etaText = duration["text"] as? String{
                                    
                                    var connectedUsers = self.usersConnectedWithETA
                                    let currentUserID = PFUser.current()?.objectId
                                    if let secs = duration["value"] as? Int{
                                        let etaInSecs = "\(secs)"
                                        self.eta = etaText
                                        let etaData = [etaInSecs, etaText]
                                        connectedUsers[currentUserID!] = etaData
                                        
                                        self.parseObject["usersconnected"] = connectedUsers
                                        self.parseObject.saveInBackground()
                                        completion()
                                    }
                                    
                                }
                            }
                            
                        }
                    }
                }
            })
            task.resume()
        }
    }
    
}
