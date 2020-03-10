//
//  UIAlertController.swift
//  Chat
//
//  Created by Jelajah Data Semesta on 11/03/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation

extension UIAlertController {
    
    static func show(title: String? = nil, message: String, completion: (() -> Void)? = nil) {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      
      alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { (_) in
        completion?()
      }))
      
      alert.present(animated: true, completion: nil)
    }
    func present(animated: Bool, completion: (() -> Void)?) {
       if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
         if rootVC.presentedViewController == nil {
           rootVC.present(self, animated: true, completion: completion)
         } else {
           rootVC.presentedViewController?.present(self, animated: true, completion: nil)
         }
       }
     }
}
