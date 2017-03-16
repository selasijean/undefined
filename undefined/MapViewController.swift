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

class MapViewController: UIViewController {
    
    var frameForSearchBarsSuperView: CGRect = CGRect(x: 0, y: 0, width: 375, height: 142)
    var frameForStartSearchBar: CGRect!
    var frameForDestinationSearchBar: CGRect!
    var backButton: UIButton!
    var mapVIew: GMSMapView!
    var startSearchBar: UISearchBar!
    var destinationSearchBar: UISearchBar!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var searchBarFrame: UIView!
    var tableView: UITableView!
    var tableViewY: CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        setupSearchBars()
        setUpMainBar()
        setUpBackButton()
        setupTableView()

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
        tableView = UITableView(frame: frameForTableView)
    
        tableViewY = 143
//        tableView.delegate = self
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
        }
    }
    


}
//extension MapViewController: UITableViewDelegate{

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

//    }

//}
//extension MapViewController: UIGestureRecognizerDelegate{
//    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//    
//}


