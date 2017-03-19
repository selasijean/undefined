//
//  MainViewController.swift
//  undefined
//
//  Created by Selasi Jean Kwame Adedze on 3/13/17.
//  Copyright © 2017 Jean Adedze. All rights reserved.
//

import UIKit
import Parse
import Material

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var userLocations: [Location] = []
    var currentLocation: CLLocation?
    
    let locationManager = CLLocationManager()
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

        setupFooterView()
        pullCurrentUserLocations()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        setupRefreshControl()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView(){
//        view.window?.isOpaque = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Color.clear
        tableView.layer.cornerRadius = 20
        tableView.layer.masksToBounds = true
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
    
    func setupRefreshControl(){
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    func onRefresh() {
        run(after: 2) {
//            self.tableView.reloadData()
            self.tableView.setNeedsLayout()
            UIView.animate(withDuration: 0.7, animations: { 
                self.userLocations = []
                self.pullCurrentUserLocations()
            })
            
//            self.tableView.layoutSubviews()
            self.refreshControl.endRefreshing()
        }
    }
    
    func run(after wait: TimeInterval, closure: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }


}
extension MainViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let destVC = self.storyboard?.instantiateViewController(withIdentifier: "detailVC")
        self.present(destVC!, animated: true, completion: nil)
        
    }
    
}

extension MainViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let fetcher = DataRequester()
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationTableViewCell
        fetcher.cell = cell
        
        let info = userLocations[indexPath.row]
        cell.setLocation(text: info.name!)
        if currentLocation?.coordinate != nil{
            fetcher.getETA(destination: info, currentLocationCoords: (currentLocation?.coordinate)!)
        }
//        cell.layer.cornerRadius = 10
////        cell.borderColor = Color.grey.darken1
//        cell.borderWidth = 1
        return cell
        
    }

}

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let location = locations.first {
            currentLocation = location
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
}
