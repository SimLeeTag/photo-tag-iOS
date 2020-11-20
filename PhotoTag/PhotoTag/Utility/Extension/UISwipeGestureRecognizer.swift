//
//  UISwipeGestureRecognizer.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/21.
//

import UIKit

extension UISwipeGestureRecognizer {
    
    static func leftSwipeGestureRecognizer(target: Any, action: Selector) -> UISwipeGestureRecognizer {
        let leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: target, action: action)
        leftSwipeGestureRecognizer.direction = .left
        return leftSwipeGestureRecognizer
    }
    
    static func rightSwipeGestureRecognizer(target: Any, action: Selector) -> UISwipeGestureRecognizer {
        let rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: target, action: action)
        rightSwipeGestureRecognizer.direction = .left
        return rightSwipeGestureRecognizer
    }
}
