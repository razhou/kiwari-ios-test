//
//  DateExtension.swift
//  Chat
//
//  Created by Jelajah Data Semesta on 11/03/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation

extension Date {
  func string(withFormat format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    formatter.locale = Locale(identifier: "en")
    
    return formatter.string(from: self)
  }
}
