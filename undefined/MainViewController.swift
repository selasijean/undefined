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
    
    @IBOutlet weak var tableViewFooterView: UIView!
    @IBOutlet weak var mainHeaderView: UIView!
    @IBOutlet weak var tableViewHeaderView: UIView!
    @IBOutlet weak var addLocationButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    var userLocations: [Location] = []
    var currentLocation: CLLocation?
    
    let locationManager = CLLocationManager()
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        setupTableView()
        setHeaderView()
        setupFooterView()
        pullCurrentUserLocations()
        
        
        
        setupRefreshControl()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Color.clear
    
    }
    
    func setHeaderView(){
        let path = UIBezierPath(roundedRect:tableViewHeaderView.bounds, byRoundingCorners:[.topLeft, .topRight], cornerRadii: CGSize(width: 20, height: 20))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.tableViewHeaderView.bounds
        maskLayer.path = path.cgPath
        tableViewHeaderView.layer.mask = maskLayer
        
        tableViewHeaderView.borderColor = tableViewFooterView.borderColor?.withAlphaComponent(0.3)
        tableView.tableHeaderView = tableViewHeaderView
    }
    
    func setupFooterView(){

        let path = UIBezierPath(roundedRect:tableViewFooterView.bounds, byRoundingCorners:[.bottomRight], cornerRadii: CGSize(width: 30, height: 30))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = tableViewFooterView.bounds
        maskLayer.path = path.cgPath
        tableViewFooterView.layer.mask = maskLayer
        tableViewFooterView.borderColor = tableViewFooterView.borderColor?.withAlphaComponent(0.3)
        addLocationButton.addTarget(self, action: #selector(addLocationButtonSelected), for: .touchUpInside)
        tableView.tableFooterView = tableViewFooterView
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
                            location.currentLocationCoords = self.currentLocation
                            location.getETA {
                            }
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
            
            self.tableView.setNeedsLayout()
            
            UIView.animate(withDuration: 0.7, animations: {
                self.userLocations = []
                self.pullCurrentUserLocations()
                self.tableView.reloadData()
                
            })
            
            self.tableView.layoutSubviews()
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationTableViewCell
        let info = userLocations[indexPath.row]
        cell.setLocation(text: info.name!)
        if currentLocation?.coordinate != nil{

            cell.setETA(text: info.eta)
        }

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
