//
//  LocationsTableViewCell.swift
//  undefined
//
//  Created by Selasi Jean Kwame Adedze on 2/17/17.
//  Copyright © 2017 Jean Adedze. All rights reserved.
//

import UIKit

class LocationsTableViewCell: UITableViewCell {
    
    var tableView : UITableView?
    
    var scrollView: UIScrollView!
    var headerView: UIView!
    var graphView: UIView!
    var detailView: UIView!
    var locationLabel: UILabel!
    var etaLabel: UILabel!
    
    var frameForScrollView: CGRect = CGRect(x: 0, y: 137, width: 375, height: 530)
    var frameForHeaderView: CGRect = CGRect(x: 0, y: 0, width: 375, height: 70)
    var frameForGraphView: CGRect = CGRect(x: 7, y: 7, width: 359, height: 166)
    var frameForDetailView: CGRect = CGRect(x: 8, y: 214, width: 358, height: 74)
    var frameForLocationLabel: CGRect = CGRect(x: 108, y: 8, width: 158, height: 51)
    var frameForETALabel: CGRect = CGRect(x: 115, y: 67, width:145, height: 39)


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeView()
        setUpHeaderViewForTableView()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Initialize main view of table View
    func initializeView(){
        headerView = UIView(frame: frameForHeaderView)
        //setUpScrollView()
        headerView.backgroundColor = UIColor.lightGray
        contentView.addSubview(headerView)
    }
    
    func setupHeaderViewOnClick(){
        locationLabel.frame = frameForLocationLabel
        locationLabel.text = "Mudd"
        etaLabel.frame  = frameForETALabel
        etaLabel.text = "50mins"
        
    }
    
    // set up scrollView of mainView
    func setUpScrollView(){
        scrollView = UIScrollView(frame: frameForScrollView)
        contentView.addSubview(scrollView)
        setGraphView()
        setUpDetailView()
    }
    
    func setLocation(text : String){
        locationLabel.text = text
    }
    
    func setETA(text: String){
        etaLabel.text = text
    }
    
    // set Graph View on scrollView
    func setGraphView(){
        graphView = UIView(frame: frameForGraphView)
        graphView.backgroundColor = UIColor.blue
        scrollView.addSubview(graphView)
    }
    
    // set detailView on scrollView
    func setUpDetailView(){
        detailView = UIView(frame: frameForDetailView)
        detailView.backgroundColor = UIColor.red
        scrollView.addSubview(detailView)
    }
    

    func setUpHeaderViewForTableView(){
        let frame = CGRect(x: 26, y: 21, width: 87, height: 21)
        locationLabel = UILabel(frame: frame)
        
        let frameForLabel = CGRect(x: 322, y: 21, width: 30, height: 21)
        etaLabel = UILabel(frame: frameForLabel)
        
        
        headerView.addSubview(locationLabel)
        headerView.addSubview(etaLabel)
    }
}
