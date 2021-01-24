//
//  NSMutableData.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/01/22.
//

import Foundation

extension NSMutableData {
  func appendString(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
