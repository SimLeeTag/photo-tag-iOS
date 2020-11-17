//
//  NSObject.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/11.
//

import UIKit

protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return Self.className
    }
}

extension NSObject: ClassNameProtocol {}
