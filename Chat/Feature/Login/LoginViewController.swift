//
//  LoginViewController.swift
//  Chat
//
//  Created by Jelajah Data Semesta on 11/03/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    
     var viewController : UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


   
    
    @IBAction func btnLogin(_ sender: Any) {
        
        self.validation()
    
    }
    
    private func validation(){
       
        guard let email = tfName.text, !email.isEmpty else {
            showMessage()
            return
        }
        guard let pass = tfPass.text, !pass.isEmpty else {
            showMessage()
            return
        }
        
        
        
        if (email != Constants.UserOne.email && pass != Constants.UserOne.password) || (email != Constants.UserTwo.email && pass != Constants.UserTwo.password) {
            self.showMessage()
        }else{
            let defaults = UserDefaults.standard
            defaults.set(email, forKey: "email")
            defaults.synchronize()
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
            controller.email = email
            self.viewController = controller
            let nav = UINavigationController(rootViewController:controller)
            UIApplication.shared.keyWindow?.rootViewController = nav
        }
        
    }
    
    private func showMessage(){
        UIAlertController.show(message: "Please check your email and password")
    }
    
}
