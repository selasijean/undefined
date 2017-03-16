//
//  SearchTableViewCell.swift
//  undefined
//
//  Created by Selasi Jean Kwame Adedze on 3/16/17.
//  Copyright © 2017 Jean Adedze. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    

    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLocationName(name: String){
        locationNameLabel.text = name
    }
    func setAddress(address: String){
        addressLabel.text = address
    }

}
