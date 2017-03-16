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

class MapViewController: UIViewController, UISearchDisplayDelegate{
    
    var frameForSearchBarsSuperView: CGRect = CGRect(x: 0, y: 0, width: 375, height: 142)
    var frameForStartSearchBar: CGRect!
    var frameForDestinationSearchBar: CGRect!
    var backButton: UIButton!
    var mapVIew: GMSMapView!
    var startSearchBar: UISearchBar!
    var destinationSearchBar: UISearchBar!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var searchBarFrame: UIView!
    
    var resultsViewController : GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    
    @IBOutlet weak var tableView: UITableView!
//    var tableView: UITableView!
    var tableViewY: CGFloat!
    
    var fetcher: GMSAutocompleteFetcher?
    var placeClient: GMSPlacesClient?
    var searchResults: [GMSPlace] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        setupSearchBars()
        setUpMainBar()
        setUpBackButton()
        setupTableView()
        configurePlaceAutoComplete()
//        setupSearchControllers()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

//        startSearchBar.searchBarStyle = .minimal
//        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.white
//        startSearchBar.isTranslucent = true
        searchBarFrame.addSubview(startSearchBar)
        searchBarFrame.addSubview(destinationSearchBar)
        
        destinationSearchBar.isHidden = true
        
        
    }
    
//    func setupSearchControllers(){
////
//////        tableDataSource = GMSAutocompleteTableDataSource()
//////        tableDataSource?.delegate = self
//////        searchController = UISearchDisplayController(searchBar: startSearchBar, contentsController: self)
//////        searchController?.searchResultsDataSource = tableDataSource
//////        searchController?.searchResultsDelegate = tableDataSource
//////        searchController?.delegate = self
////        
//        resultsViewController = GMSAutocompleteResultsViewController()
//        resultsViewController?.delegate = self
//
//        
//        searchController = UISearchController(searchResultsController: resultsViewController)
//        searchController?.searchResultsUpdater = resultsViewController
//        view.addSubview((searchController?.searchBar)!)
//
//    }
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
        tableView.delegate = self
        tableView.dataSource = self
        backgroundView.addSubview(tableView)
        
    }
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
//    func didPan(sender: UIPanGestureRecognizer){
//        let velocity = sender.velocity(in: tableView)
//        if velocity.y > 20 {
//            UIView.animate(withDuration: 0.20, animations: { 
//                self.tableView.frame.origin.y = self.tableViewY + sender.translation(in: self.tableView).y
//            })
//        }
//    }
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
        fetcher = GMSAutocompleteFetcher(bounds: nil, filter: filter)
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
//            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.red
            self.backButton.isHidden = false
            self.destinationSearchBar.isHidden = false
            self.tableView.frame.origin.y = 143
//            self.present(self.resultsViewController!, animated: true, completion: nil)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults = []
        fetcher?.sourceTextHasChanged(searchText)
    }
    


}
extension MapViewController: UITableViewDelegate{

//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y < 0{
//                let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
//                panGestureRecognizer.delegate = self
//                tableView.addGestureRecognizer(panGestureRecognizer)
//            print("selasi")
//            UIView.animate(withDuration: 0.1, animations: {
//                self.tableView.frame.origin.y = self.tableViewY + scrollView.contentOffset.y
//                print(self.tableView.frame.origin.y)
//            })
//            tableView.frame.origin.y = tableView.frame.origin.y + scrollView.contentOffset.y
//        }
//
//    }
    
    

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
//extension MapViewController: UIGestureRecognizerDelegate{
//    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//    
//}

extension MapViewController: GMSAutocompleteResultsViewControllerDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        print("Place name: ", place.name)
        print("Place address: ", place.formattedAddress)
        print("Place attributions: ", place.attributions)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictionsForResultsController(resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictionsForResultsController(resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    
}
extension MapViewController: GMSAutocompleteFetcherDelegate {
    
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
//        let resultsStr = NSMutableString()
//        print(predictions.count)
        for prediction in predictions {
//            placeClient?.lookUpPlaceID(prediction.placeID!, callback: { (place: GMSPlace?, error: Error?) in
//                
//                if let error = error {
//                    print("lookup place id query error: \(error.localizedDescription)")
//                    return
//                }
//                
//                guard let place = place else {
//                    print("No place details for \(prediction.placeID)")
//                    return
//                }
//                
//                self.searchResults.append(place)
//                print(self.searchResults.count)
////                print("Place name \(place.name)")
////                print("Place address \(place.formattedAddress)")
////                print("Place placeID \(place.placeID)")
////                print("Place attributions \(place.attributions)")
//            })
            print(prediction.attributedFullText)
//            resultsStr.appendFormat("%@\n", prediction.attributedPrimaryText)
        }
        tableView.reloadData()
        
//        resultText?.text = resultsStr as String
    }
    
    func didFailAutocompleteWithError(_ error: Error) {
        print(error.localizedDescription)
    }
}

