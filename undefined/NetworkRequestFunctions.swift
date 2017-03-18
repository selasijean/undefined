//
//  NetworkRequestFunctions.swift
//  undefined
//
//  Created by Selasi Jean Kwame Adedze on 3/17/17.
//  Copyright © 2017 Jean Adedze. All rights reserved.
//

import UIKit

class NetworkRequestFunctions: NSObject {
    
    class func getETA(){
        let path = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=34.106322,-117.710491&destinations=34.098781, -117.700159&key=AIzaSyC3DeaKs0Dg4iipA-N2bfu0qJyvkJAtc9g".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlString = URL(string: path!)
        let config = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: config)
        if let url = urlString {
            let task = urlSession.dataTask(with: url, completionHandler: { (data:Data?, response: URLResponse?, error: Error?) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    if let usableData = data {
//                        print(usableData)
                        let json = try? JSONSerialization.jsonObject(with: usableData, options: [])
                        print(json)
                    }
                }
            })
            task.resume()
        }
    }
}
