//
//  MainViewController.swift
//  undefined
//
//  Created by Selasi Jean Kwame Adedze on 3/13/17.
//  Copyright © 2017 Jean Adedze. All rights reserved.
//

import UIKit

struct userDestination {
    var name: String
    var eta : String
    
    init(destinationName: String, etaToDes: String){
        name = destinationName
        eta = etaToDes
    }
}

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var locations: [userDestination] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

        setupFooterView()
        populateLocationsArray()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
//        tableView.tableFooterView?.isUserInteractionEnabled = true
    
        
    }
    func setupFooterView(){
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        footerView.backgroundColor = UIColor.black
        footerView.isUserInteractionEnabled = true
        let addButton = UIButton()
        addButton.frame = footerView.frame
        addButton.setTitle("Add Location", for: .normal)
        addButton.addTarget(self, action: #selector(addLocationButtonSelected), for: .touchUpInside)
        footerView.addSubview(addButton)
        tableView.tableFooterView = footerView
        tableView.tableFooterView?.isUserInteractionEnabled = true
        
    }
    
    func addLocationButtonSelected(){
        print("selasi")
        let destVC = self.storyboard?.instantiateViewController(withIdentifier: "mapView")
        self.present(destVC!, animated: true, completion: nil)
        
    }


    func populateLocationsArray(){
        let location1 = userDestination(destinationName: "mudd", etaToDes: "50mins")
        let location2 = userDestination(destinationName: "pomona", etaToDes: "20mins")
        let location3 = userDestination(destinationName: "gym", etaToDes: "10mins")
        let location4 = userDestination(destinationName: "mudd", etaToDes: "50mins")
        let location5 = userDestination(destinationName: "pomona", etaToDes: "20mins")
        let location6 = userDestination(destinationName: "gym", etaToDes: "10mins")
        let location7 = userDestination(destinationName: "mudd", etaToDes: "50mins")
        let location8 = userDestination(destinationName: "pomona", etaToDes: "20mins")
        let location9 = userDestination(destinationName: "gym", etaToDes: "10mins")
        let location10 = userDestination(destinationName: "gym", etaToDes: "10mins")
        locations.append(location1)
        locations.append(location2)
        locations.append(location3)
        locations.append(location4)
        locations.append(location5)
        locations.append(location6)
        locations.append(location7)
        locations.append(location8)
        locations.append(location9)
        locations.append(location10)
    }
    

}
extension MainViewController: UITableViewDelegate{
    
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        
//        return 50
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let destVC = self.storyboard?.instantiateViewController(withIdentifier: "detailVC")
        self.present(destVC!, animated: true, completion: nil)
        
    }
    
}

extension MainViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationTableViewCell
        
        let info = locations[indexPath.row]
        
        cell.setLocation(text: info.name)
        cell.setETA(text: info.eta)
        return cell
        
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        
//        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
//        footerView.backgroundColor = UIColor.black
//        
//        let addButton = UIButton(frame: footerView.frame)
//
//        addButton.setTitle("Add Location", for: .normal)
//        addButton.addTarget(self, action: #selector(addLocationButtonSelected), for: UIControlEvents.touchUpInside)
//        footerView.addSubview(addButton)
//        footerView.isUserInteractionEnabled = true
//        return footerView
//    }
}
