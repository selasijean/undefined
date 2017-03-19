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
    
    var parseObject: PFObject!{
        didSet{
            name = parseObject["name"] as? String
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
    
    init(pfObject: PFObject){
        super.init()
        ({self.parseObject = pfObject})()
    }
    
}
