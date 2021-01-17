//
//  Array.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/01/17.
//

import Foundation

extension Array where Element: Hashable {
   
  /// 순서는 그대로, 중복 값만 삭제
  var uniques: Array {
    var buffer = Array()
    var added = Set<Element>()
    for elem in self {
      if !added.contains(elem) {
        buffer.append(elem)
        added.insert(elem)
      }
    }
    return buffer
  }
   
}
