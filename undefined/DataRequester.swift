//
//  NetworkRequestFunctions.swift
//  undefined
//
//  Created by Selasi Jean Kwame Adedze on 3/17/17.
//  Copyright © 2017 Jean Adedze. All rights reserved.
//

import UIKit
import GoogleMaps

class DataRequester: NSObject {
    
    var cell : LocationTableViewCell?
    var tableView: UITableView?

    func getETA(destination: Location, currentLocationCoords: CLLocationCoordinate2D) {

        let latitude = String(describing: destination.coordinates?.latitude)
        let longitude = String(describing: destination.coordinates?.longitude)
        let destString = "=place_id:" + "\((destination.placeID)!)"
        let path = ("https://maps.googleapis.com/maps/api/distancematrix/json?origins=" + "\(latitude)" + "\(longitude)" + "&destinations" + "\(destString)" + "&key=AIzaSyC3DeaKs0Dg4iipA-N2bfu0qJyvkJAtc9g").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

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
                        if let first = rows?.first{
                            print(first)
                            let firstElement = first["elements"] as? [NSDictionary]
                            if let duration = firstElement?.first!["duration"] as? NSDictionary{
                                if let eta = duration["text"] as? String{

                                    self.cell?.setETA(text: eta)
                                    self.cell?.setNeedsLayout()
                                    self.tableView?.reloadData()
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
