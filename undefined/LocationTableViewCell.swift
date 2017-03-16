//
//  LocationTableViewCell.swift
//  undefined
//
//  Created by Selasi Jean Kwame Adedze on 3/13/17.
//  Copyright © 2017 Jean Adedze. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var etaLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLocation(text : String){
        destinationLabel.text = text
    }
    
    func setETA(text: String){
        etaLabel.text = text
    }

}
