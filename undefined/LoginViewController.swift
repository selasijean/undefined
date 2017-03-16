//
//  LoginViewController.swift
//  undefined
//
//  Created by Selasi Jean Kwame Adedze on 2/5/17.
//  Copyright © 2017 Jean Adedze. All rights reserved.
//

import UIKit
import Parse
import Material

class LoginViewController: UIViewController {
    

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var navigationVC: NavigationDrawerController!
    var homeVC: UIViewController!
    var menuVC: MenuViewController!
    var keyboardAppeared: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHomeVC()
        setupMenuVC()
        setUpNavigationDrawerVC()
        addNotificationObservers()
        changeTextFieldProperties()

        // Do any additional setup after loading the view.
    }
    
    func performLogin(){
        
        if (!(usernameField.text?.isEmpty)! && !(passwordField.text?.isEmpty)!){
            PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!, block: { (user:PFUser?, error:Error?) in
                if user != nil{
                    print("successful login")
                    self.present(self.navigationVC, animated: true, completion: nil)
                }
            })
        }
    }
    
    func changeTextFieldProperties(){
        usernameField.autocapitalizationType = .none
        usernameField.autocorrectionType = .no
        passwordField.autocorrectionType = .no
        passwordField.autocapitalizationType = .none
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
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        performLogin()
    }
    
    func addNotificationObservers(){
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification){
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        if !keyboardAppeared{
            UIView.animate(withDuration: 3.0) {
                self.keyboardAppeared = true
                self.view.frame.origin.y = self.view.frame.origin.y - keyboardViewEndFrame.height
                
            }
        }
    }
    
    func keyboardWillHide(_ notification: Notification){
        UIView.animate(withDuration: 3.0, animations: {
            self.view.frame.origin.y = 0
        })
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
