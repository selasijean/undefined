//
//  NetworkRequestFunctions.swift
//  undefined
//
//  Created by Selasi Jean Kwame Adedze on 3/17/17.
//  Copyright © 2017 Jean Adedze. All rights reserved.
//

import UIKit
import GoogleMaps
import Parse

class DataRequester: NSObject {
    
    var cell : LocationTableViewCell?
    var tableView: UITableView?

//    func getETA(destination: Location, currentLocationCoords: CLLocationCoordinate2D) {
//        
//
//        let latitude = String(describing: currentLocationCoords.latitude)
//        let longitude = String(describing: currentLocationCoords.longitude)
//        let destString = "=place_id:" + "\((destination.placeID)!)"
//        let path = ("https://maps.googleapis.com/maps/api/distancematrix/json?origins=" + "\(latitude)," + "\(longitude)" + "&destinations" + "\(destString)" + "&key=AIzaSyC3DeaKs0Dg4iipA-N2bfu0qJyvkJAtc9g").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        
//        
//        let urlString = URL(string: path!)
////        print(urlString!)
//        let config = URLSessionConfiguration.default
//        let urlSession = URLSession(configuration: config)
//        
//        
//        if let url = urlString {
//            let task = urlSession.dataTask(with: url, completionHandler: { (data:Data?, response: URLResponse?, error: Error?) in
//                if error != nil {
//                    print(error?.localizedDescription)
//                } else {
//                    if let usableData = data {
//                        let json = try? JSONSerialization.jsonObject(with: usableData, options: []) as! NSDictionary
//                        let rows = json!["rows"] as? [NSDictionary]
//                        print(rows)
//                        if let first = rows?.first{
//                            let firstElement = first["elements"] as? [NSDictionary]
////                            print(firstElement)
//                            if let duration = firstElement?.first!["duration"] as? NSDictionary{
////                                print(duration)
//                                if let etaText = duration["text"] as? String{
//                                    var connectedUsers = destination.usersConnectedWithETA
//                                    let currentUserID = PFUser.current()?.objectId
//                                    if let secs = duration["value"] as? Int{
//                                        let etaInSecs = "\(secs)"
//                                        let etaData = [etaInSecs, etaText]
//                                        connectedUsers[currentUserID!] = etaData
//                                        destination.parseObject["usersconnected"] = connectedUsers
//                                        self.cell?.setETA(text: etaText)
//                                        destination.parseObject.saveInBackground()
//                                        self.cell?.setNeedsLayout()
//                                        self.tableView?.reloadData()
//                                    }
//
//                                }
//                            }
//                          
//                        }
//                    }
//                }
//            })
//            task.resume()
//        }
//    }
   }
