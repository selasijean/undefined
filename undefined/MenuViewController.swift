//
//  ViewController.swift
//  undefined
//
//  Created by Selasi Jean Kwame Adedze on 2/5/17.
//  Copyright © 2017 Jean Adedze. All rights reserved.
//

import UIKit
import Material

class MenuViewController: UIViewController {

    var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView(){
        view.backgroundColor =  Color.grey.darken4
        view.alpha = 0.9
        
    }

}

