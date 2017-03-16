//
//  SignUpViewController.swift
//  undefined
//
//  Created by Selasi Jean Kwame Adedze on 2/8/17.
//  Copyright © 2017 Jean Adedze. All rights reserved.
//

import UIKit
import Parse
import Material

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var retypePasswordField: UITextField!
    var navigationVC: NavigationDrawerController!
    var homeVC: UIViewController!
    var menuVC: MenuViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpHomeVC()
        setupMenuVC()
        setUpNavigationDrawerVC()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func createNewUser(){
        let newUser = PFUser()
        newUser.email = emailField.text
        newUser.username = usernameField.text
        
        if !((passwordField.text?.isEmpty)! && (retypePasswordField.text?.isEmpty)!) && (passwordField.text == retypePasswordField.text){
            newUser.password = passwordField.text
            newUser.signUpInBackground(block: { (success:Bool, error:Error?) in
                if success {
                    print("Yay")
                    self.present(self.navigationVC, animated: true, completion: nil)

                }else{
                    print(error?.localizedDescription)
                }
            })
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        createNewUser()
    }
    
    func setupMenuVC(){
        menuVC = MenuViewController()
    }
    
    func setUpHomeVC(){
        homeVC = self.storyboard?.instantiateViewController(withIdentifier: "homepage")
    }
    
    func setUpNavigationDrawerVC(){
        
        navigationVC = NavigationDrawerController(rootViewController: homeVC, leftViewController: menuVC, rightViewController: nil)
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
