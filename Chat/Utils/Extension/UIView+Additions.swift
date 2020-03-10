//
//  UIView+Additions.swift
//  Chat
//
//  Created by Jelajah Data Semesta on 10/03/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit

extension UIView {
  
  func smoothRoundCorners(to radius: CGFloat) {
    let maskLayer = CAShapeLayer()
    maskLayer.path = UIBezierPath(
      roundedRect: bounds,
      cornerRadius: radius
    ).cgPath
    
    layer.mask = maskLayer
  }
  
}
