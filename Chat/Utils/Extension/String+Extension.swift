//
//  String+Extension.swift
//  Chat
//
//  Created by Jelajah Data Semesta on 11/03/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation

extension String {
    
    func strToDate(withFormat format: String, timeZone: TimeZone? = TimeZone.current) -> Date? {
      let formatter = DateFormatter()
      formatter.dateFormat = format
      formatter.locale = Locale(identifier: "en")
      formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
      return formatter.date(from: self)
    }
}
