//
//  DetailViewController.swift
//  undefined
//
//  Created by Selasi Jean Kwame Adedze on 3/15/17.
//  Copyright © 2017 Jean Adedze. All rights reserved.
//

import UIKit
import MXParallaxHeader
import Charts

class DetailViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var headerView: UIImageView!
    var location : Location?
    
    @IBOutlet weak var demo: RadarChartView!
    @IBOutlet weak var barChartView: BarChartView!
    
    var months: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
        
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
//        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        let unitsSold = [20.0, 8.0, 6.0, 12.0, 12.0, 16.0, 4.0, 18.0, 6.0, 10.0, 8.0, 9.0]
        
        setChart(dataPoints: months, values: unitsSold)
        scrollView.contentSize = CGSize(width: 375, height: 1000)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func setupHeaderView(){
        headerView = UIImageView()
        headerView.image = UIImage(named: "krabs")
        headerView.contentMode = .scaleAspectFill
        scrollView.parallaxHeader.view = headerView
        scrollView.parallaxHeader.height = 150
        scrollView.parallaxHeader.mode = .fill
        scrollView.parallaxHeader.minimumHeight = 20
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
//            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Number of people arriving")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.dragEnabled = false
        barChartView.chartDescription?.text = "Test"
        
        var frame = barChartView.frame
        frame.origin.y = frame.origin.y + barChartView.frame.size.height + 50
//        let demo = RadarChartView(frame: frame)
        scrollView.addSubview(demo)
//        let radarDataEntry = RadarChartDataEntry(
        let radarChartDataSet = RadarChartDataSet(values: dataEntries, label: "Number of people arriving")
        radarChartDataSet.drawValuesEnabled = false
        radarChartDataSet.fillColor = UIColor.blue
        radarChartDataSet.drawFilledEnabled = true
        let radarData = RadarChartData(dataSet: radarChartDataSet)
        
        
        demo.data = radarData
        barChartView.data = chartData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissVC(_ sender: Any) {
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

}
