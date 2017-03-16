//
//  User.swift
//  undefined
//
//  Created by Selasi Jean Kwame Adedze on 2/8/17.
//  Copyright © 2017 Jean Adedze. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class User: NSObject {
    
    var parseObject: PFObject!{
        didSet{
            name = parseObject["name"] as? String
            email = parseObject["email"] as? String
            profilePhoto = parseObject["profilePhoto"] as? PFFile
            gender = parseObject["gender"] as? String
            destinations = parseObject["destinations"] as? [String]
        }
    }
    var name: String?
    var email: String?
    var profilePhoto: PFFile?
    var gender: String?
    var destinations: [String]?
    
    init(pfObject: PFObject){
        super.init()
            ({self.parseObject = pfObject})()
    }
}
