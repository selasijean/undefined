//
//  ViewController.swift
//  undefined
//
//  Created by Selasi Jean Kwame Adedze on 2/5/17.
//  Copyright © 2017 Jean Adedze. All rights reserved.
//

import UIKit
import Material
import Parse

class MenuViewController: UIViewController {
    
    var tableView: UITableView!
    var profileContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
        setupProfileView()
        prepareTableView()
    }
    
    func setupProfileView(){
        let frameForContainerView = CGRect(x: 0, y: 0,width: view.bounds.width, height: 64)
        profileContainerView = UIView(frame: frameForContainerView)
        profileContainerView.backgroundColor = UIColor.gray
        view.addSubview(profileContainerView)
    }
    
    func prepareTableView(){
        
        tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "MenuTableViewCell")
        tableView.backgroundColor = UIColor.clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        view.layout(tableView).edges(top: profileContainerView.bounds.height)
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

extension MenuViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath)
        cell.textLabel?.text = "Sign Out"
        cell.textLabel?.textColor = Color.grey.lighten2
        cell.backgroundColor = Color.clear
        return cell
    }
    

}

extension MenuViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            PFUser.logOutInBackground(block: { (error: Error?) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let logVC = storyboard.instantiateViewController(withIdentifier: "loginVC")
                logVC.modalPresentationStyle = .fullScreen
                self.present(logVC, animated: true, completion: nil)
            })

        }
    }
    
}

