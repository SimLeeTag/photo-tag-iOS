//
//  UsesAutoLayout.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/13.
//

import UIKit

@propertyWrapper
public struct UsesAutoLayout<T: UIView> {
    public var wrappedValue: T
    
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
