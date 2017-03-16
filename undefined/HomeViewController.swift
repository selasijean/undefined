////
////  HomeViewController.swift
////  undefined
////
////  Created by Selasi Jean Kwame Adedze on 2/5/17.
////  Copyright © 2017 Jean Adedze. All rights reserved.
////
//
//import UIKit
//
//struct userDestination {
//    var name: String
//    var eta : String
//    
//    init(destinationName: String, etaToDes: String){
//        name = destinationName
//        eta = etaToDes
//    }
//    
//}
//
//class HomeViewController: UIViewController{
//
//    var userLocations: [Location]?
//    var selectedRowIndex: Int = -1
//    var tableView: UITableView!
//    var locations: [userDestination] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupTableView()
//        populateLocationsArray()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func setupTableView(){
//        tableView = UITableView()
//        tableView.frame = view.bounds
//        tableView.register(LocationsTableViewCell.self, forCellReuseIdentifier: "Info")
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.backgroundColor = UIColor.white
//        tableView.tableFooterView = UIView()
//        view.addSubview(tableView)
//        
//    }
//    
//    func populateLocationsArray(){
//        let location1 = userDestination(destinationName: "mudd", etaToDes: "50mins")
//        let location2 = userDestination(destinationName: "pomona", etaToDes: "20mins")
//        let location3 = userDestination(destinationName: "gym", etaToDes: "10mins")
//        
//        locations.append(location1)
//        locations.append(location2)
//        locations.append(location3)
//        
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//extension HomeViewController: UITableViewDelegate{
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        if indexPath.row == selectedRowIndex{
////            return view.bounds.height
////        }
//        return 70
//    }
//    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
////        tableView.beginUpdates()
////        selectedRowIndex = indexPath.row
////        tableView.endUpdates()
////        if indexPath.row == selectedRowIndex{
////            selectedRowIndex = -1
////        }else{
////            selectedRowIndex = indexPath.row
////        }
////        tableView.reloadData()
//    }
//}
//
//extension HomeViewController: UITableViewDataSource{
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return locations.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Info", for: indexPath) as! LocationsTableViewCell
//        
//        let info = locations[indexPath.row]
//        
//        cell.setLocation(text: info.name)
//        cell.setETA(text: info.eta)
//        
//        return cell
//        
//    }
//    
//    
//}
