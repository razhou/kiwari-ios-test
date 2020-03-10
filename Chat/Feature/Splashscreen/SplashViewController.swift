//
//  SplashViewController.swift
//  Chat
//
//  Created by Jelajah Data Semesta on 11/03/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    var viewController : UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard

        if  let email = defaults.string(forKey: "email")
        {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
            controller.email = email
            self.viewController = controller
            let nav = UINavigationController(rootViewController:controller)
            UIApplication.shared.delegate?.window??.rootViewController = nav
        }else{
            
            let login = LoginViewController(nibName: "LoginViewController", bundle: nil)
             UIApplication.shared.delegate?.window??.rootViewController = login
            
        }
        // Do any additional setup after loading the view.r
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
