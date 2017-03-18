//
//  MainViewController.swift
//  undefined
//
//  Created by Selasi Jean Kwame Adedze on 3/13/17.
//  Copyright © 2017 Jean Adedze. All rights reserved.
//

import UIKit
import Parse
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
    var userLocations: [Location] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

        setupFooterView()
        populateLocationsArray()
        pullCurrentUserLocations()
//        NetworkRequestFunctions.getETA()
        
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
        let destVC = self.storyboard?.instantiateViewController(withIdentifier: "mapView") as? MapViewController
        destVC?.parentVC = self
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
    
    func pullCurrentUserLocations(){
        
        let arrayLocations = PFUser.current()?.object(forKey: "locations") as? [[String: String]]
        if let locDict = arrayLocations{
            for dict in locDict{
                if let index = dict.index(forKey: "parse_id"){
                    let query = PFQuery(className: "Locations")
                    query.whereKey("objectId", equalTo: dict[index].value)
                    query.findObjectsInBackground(block: { (results: [PFObject]?, error: Error?) in
                        
                        let pfObject = results?[0]
                        
                        if let object = pfObject{
                            let location = Location(pfObject: object)
                            self.userLocations.append(location)
                            self.tableView.reloadData()
                        }
                    })
                }
            }
        }
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
        return userLocations.count
//        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationTableViewCell
        let info = userLocations[indexPath.row]
//        let info = locations[indexPath.row]
        
        cell.setLocation(text: info.name!)
        cell.setETA(text: "20mins")
//        cell.setETA(text: info.eta)
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
