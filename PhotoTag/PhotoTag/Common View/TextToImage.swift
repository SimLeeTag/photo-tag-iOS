//
//  TextToImage.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/04/16.
//

import UIKit

func textToImage(drawText text: String, inImage image: UIImage, inCGRect rect: CGRect) -> UIImage {
    let textColor = UIColor.white
    let textFont = UIFont.systemFont(ofSize: 50)
    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
    
    let textFontAttributes = [
        NSAttributedString.Key.font: textFont,
        NSAttributedString.Key.foregroundColor: textColor]
        as [NSAttributedString.Key: Any]
    image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
    
    text.draw(in: rect, withAttributes: textFontAttributes)
    
    guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
    
    UIGraphicsEndImageContext()
    
    return newImage
}
