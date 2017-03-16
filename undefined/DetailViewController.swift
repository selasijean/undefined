//
//  DetailViewController.swift
//  undefined
//
//  Created by Selasi Jean Kwame Adedze on 3/15/17.
//  Copyright © 2017 Jean Adedze. All rights reserved.
//

import UIKit
import MXParallaxHeader

class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var headerView: UIImageView!
    var location : Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
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
