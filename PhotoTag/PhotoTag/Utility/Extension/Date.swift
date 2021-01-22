//
//  Date.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/01/22.
//

import Foundation

extension Date {
 var millisecondsSince1970: Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds: Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}
