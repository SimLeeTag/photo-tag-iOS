//
//  Colors.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/10.
//

import UIKit

extension UIColor {
    public class var keyColorInLightMode: UIColor {
        return #colorLiteral(red: 0.3720000088, green: 0.3149999976, blue: 0.7599999905, alpha: 1)
    }
    
    public class var keyColorInDarkMode: UIColor {
        return #colorLiteral(red: 0.9990000129, green: 0.7210000157, blue: 0.01999999955, alpha: 1)
    }
    
    static func fade(fromRed: CGFloat,
              fromGreen: CGFloat,
              fromBlue: CGFloat,
              fromAlpha: CGFloat,
              toRed: CGFloat,
              toGreen: CGFloat,
              toBlue: CGFloat,
              toAlpha: CGFloat,
              withPercentage percentage: CGFloat) -> UIColor {
        
        let red: CGFloat = (toRed - fromRed) * percentage + fromRed
        let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
        let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
        let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha
        
        // return the fade colour
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
