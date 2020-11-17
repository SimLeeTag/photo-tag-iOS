//
//  UIView.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/11.
//

import UIKit

extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle: Bundle? = nil) -> UIView? {
      return UINib(
          nibName: nibNamed,
          bundle: bundle
      ).instantiate(withOwner: nil, options: nil)[.zero] as? UIView
  }
}
