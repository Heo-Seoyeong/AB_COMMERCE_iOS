//
//  Int+Extension.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/08.
//

import Foundation

extension Int {
  
  var decimalString: String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    return numberFormatter.string(from: NSNumber(value: self)) ?? ""
  }
  
}
