//
//  MapViewController.swift
//  undefined
//
//  Created by Selasi Jean Kwame Adedze on 2/7/17.
//  Copyright © 2017 Jean Adedze. All rights reserved.
//

import UIKit
import GoogleMaps
import Material
import Parse

class MapViewController: UIViewController, UISearchDisplayDelegate{
    
    var parentVC: MainViewController?
    var frameForSearchBarsSuperView: CGRect = CGRect(x: 0, y: 0, width: 375, height: 142)
    var frameForStartSearchBar: CGRect!
    var frameForDestinationSearchBar: CGRect!
    var backButton: UIButton!
    
    var mapVIew: GMSMapView!
    let locationManager = CLLocationManager()
    
    var startSearchBar: UISearchBar!
    var destinationSearchBar: UISearchBar!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var searchBarFrame: UIView!
    
    var resultsViewController : GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var locationDetailView: UIView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var modeOfTravelImageView: UIImageView!
    
    var selectedLocation: GMSPlace?
    
//    var tableView: UITableView!
    var tableViewY: CGFloat!
    
    var fetcher: GMSAutocompleteFetcher?
    var placeClient: GMSPlacesClient?
    var googleMapsPredictions: [GMSAutocompletePrediction] = []
    var searchResults: [GMSPlace] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        setupSearchBars()
        setUpMainBar()
        setUpBackButton()
        setupTableView()
        configurePlaceAutoComplete()
        hideLocationDetailView()
        
        locationManager.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideLocationDetailView(){
        locationDetailView.frame.origin.y = view.height
    }
    
    func showLocationDetailView(){
        
        UIView.animate(withDuration: 0.4) {
            self.tappedBackButton()
        }
        UIView.animate(withDuration: 0.6) {
            self.locationDetailView.frame.origin.y = 296
            self.searchBarFrame.isHidden = true
            self.self.mapVIew.addSubview(self.locationDetailView)
        }
    }
    
    @IBAction func closeLocationDetailView(_ sender: Any) {
        UIView.animate(withDuration: 0.4) { 
            self.hideLocationDetailView()
        }
        
    }
    @IBAction func saveLocation(_ sender: Any) {
        
        let location = PFObject(className: "Locations")
        location["name"] = selectedLocation?.name
        location["place_id"] = (selectedLocation?.placeID)!
        
        let userConnectedDic = NSMutableDictionary()
        userConnectedDic.setValue("29mins", forKey: "\((PFUser.current()?.objectId)!)")
        location["usersconnected"] = userConnectedDic
       
        let locationInfoUser = NSMutableDictionary()
//        locationInfoUser.setValue("\((selectedLocation?.placeID)!)", forKey: "placeID")
        locationInfoUser.setValue("\((selectedLocation?.name)!)", forKey: "name")
        locationInfoUser.setValue("\((selectedLocation?.formattedAddress)!)", forKey: "address")
        locationInfoUser.setValue("\((selectedLocation?.coordinate)!)", forKey: "coords")
        
        
        
        location.saveInBackground { (success: Bool, error: Error?) in
            if success{
                self.dismissView(sender)
                if var newlocInfo = PFUser.current()?.object(forKey: "locations") as? [NSMutableDictionary]{
                    newlocInfo.append(locationInfoUser)
                    PFUser.current()?.setObject(newlocInfo, forKey: "locations")
                }else{
                    PFUser.current()?.setObject(NSArray(array: [locationInfoUser]), forKey: "locations")
                }
                locationInfoUser.setValue("\((location.objectId)!)", forKey: "parse_id")
                PFUser.current()?.saveInBackground(block: { (success:Bool, error:Error?) in
                    if success{
                        self.parentVC?.userLocations = []
                        self.parentVC?.pullCurrentUserLocations()
                    }
                })
                
            }
        }
        
    }
    
    func setupSearchBars(){
        
        frameForDestinationSearchBar = CGRect(x: 0, y: 0, width: 313, height: 38)
        frameForStartSearchBar = CGRect(x: 0, y: 0, width: 313, height: 38)
        startSearchBar = UISearchBar()
        startSearchBar.placeholder = "Where To"
        startSearchBar.frame = frameForStartSearchBar
        
        destinationSearchBar = UISearchBar()
        destinationSearchBar.frame = frameForDestinationSearchBar
        destinationSearchBar.placeholder = "Current Location"
        destinationSearchBar.backgroundImage = UIImage()
        destinationSearchBar.barTintColor = UIColor.clear
        destinationSearchBar.borderColor = UIColor.clear
        
        startSearchBar.barTintColor = UIColor.clear
        startSearchBar.borderColor = UIColor.clear
        startSearchBar.backgroundImage = UIImage()
        startSearchBar.delegate = self
        searchBarFrame.addSubview(startSearchBar)
        searchBarFrame.addSubview(destinationSearchBar)
        
        destinationSearchBar.isHidden = true
        
        
    }

    func setUpMainBar(){
        searchBarFrame.frame = CGRect(x: 33, y: 70, width: 313, height: 38)

        searchBarFrame.layer.shadowColor = UIColor.black.cgColor
        searchBarFrame.layer.shadowOpacity = 1
        searchBarFrame.layer.shadowOffset = CGSize.zero
        searchBarFrame.layer.shadowRadius = 2
        backgroundView.addSubview(searchBarFrame)
    }
    
    
    func setUpBackButton(){
        backButton = UIButton(frame: CGRect(x: 5, y: 8, width: 70, height: 30))
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(UIColor.blue, for: .normal)
        backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        searchBarFrame.addSubview(backButton)
        backButton.isHidden = true
        
    }
    
    func tappedBackButton(){
        UIView.animate(withDuration: 0.35) {
            
            self.searchBarFrame.frame = CGRect(x: 33, y: 70, width: 313, height: 38)
            self.startSearchBar.frame = self.frameForStartSearchBar
            self.searchBarFrame.backgroundColor = UIColor.white
            self.backButton.isHidden = true
            self.destinationSearchBar.isHidden = true
            self.startSearchBar.resignFirstResponder()
            self.tableView.frame.origin.y = 667
            
        }
    }
    
    func setupMapView(){
        let frameForMapView = view.bounds
        mapVIew = GMSMapView(frame: frameForMapView)
        backgroundView.addSubview(mapVIew)
    }
    
    func setupTableView(){
        let frameForTableView = CGRect(x: 0, y: 667, width: 375, height: 527)
//        tableView = UITableView(frame: frameForTableView)
        tableView.frame = frameForTableView
        tableViewY = 143
        tableView.dataSource = self
        tableView.delegate = self
        backgroundView.addSubview(tableView)
        
    }
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func didUpdateAutocompletePredictionsForTableDataSource(tableDataSource: GMSAutocompleteTableDataSource) {
        // Turn the network activity indicator off.
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        // Reload table data.
//        searchDisplayController?.searchResultsTableView.reloadData()
    }
    
    func didRequestAutocompletePredictionsForTableDataSource(tableDataSource: GMSAutocompleteTableDataSource) {
        // Turn the network activity indicator on.
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        // Reload table data.
//        searchDisplayController?.searchResultsTableView.reloadData()
    }

    func configurePlaceAutoComplete(){
        
        let visibleRegion = mapVIew.projection.visibleRegion()
        let bounds = GMSCoordinateBounds(coordinate: visibleRegion.farLeft, coordinate: visibleRegion.nearRight)

        // Set up the autocomplete filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter
        
        // Create the fetcher.
        fetcher = GMSAutocompleteFetcher(bounds: bounds, filter: filter)
        fetcher?.delegate = self
        
        placeClient = GMSPlacesClient()
        
    }

}
extension MapViewController : UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.35) {
            self.searchBarFrame.frame = self.frameForSearchBarsSuperView
            self.searchBarFrame.backgroundColor = UIColor.lightGray
            self.startSearchBar.frame = CGRect(x: 43, y: 83, width: 308, height: 33)
            self.destinationSearchBar.frame = CGRect(x: 43, y: 33, width: 308, height: 33)
            self.startSearchBar.barTintColor = UIColor.red
            self.backButton.isHidden = false
            self.destinationSearchBar.isHidden = false
            self.tableView.frame.origin.y = 143
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults = []
        googleMapsPredictions = []
        fetcher?.sourceTextHasChanged(searchText)
    }
    
}
extension MapViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = searchResults[indexPath.row]
        selectedLocation = location
        locationNameLabel.text = location.name
        showLocationDetailView()
    }
}

extension MapViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let place = searchResults[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        cell.setAddress(address: place.formattedAddress!)
        cell.setLocationName(name: place.name)
        print(place.name)
        return cell
    }
}

extension MapViewController: GMSAutocompleteResultsViewControllerDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        
        print("Error: ", error.localizedDescription)
    }
    
    func didRequestAutocompletePredictionsForResultsController(resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictionsForResultsController(resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    
}
extension MapViewController: GMSAutocompleteFetcherDelegate {
    
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {

        for prediction in predictions {
            placeClient?.lookUpPlaceID(prediction.placeID!, callback: { (place: GMSPlace?, error: Error?) in
                
                if let error = error {
                    print("lookup place id query error: \(error.localizedDescription)")
                    return
                }
                
                guard let place = place else {
                    print("No place details for \(prediction.placeID)")
                    return
                }
                
                self.searchResults.append(place)
                self.tableView.reloadData()

            })

        }
    }
    
    func didFailAutocompleteWithError(_ error: Error) {
        print(error.localizedDescription)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            mapVIew.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapVIew.isMyLocationEnabled = true
            mapVIew.settings.myLocationButton = true
        }
    }

}

