//
//  PhotoNoteOperation.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/04/15.
//

import UIKit

// define the content for the operation image needs in the abstract class
class PhotoNoteOperation: ImageFilterOperation {
    
    override func main() {
        if isCancelled { return }
        guard let inputImages = filterInputs else { return }
        
        if isCancelled { return }
        var temp = [UIImage]()
        var memo = ""
        if let textArr = textArr { memo = textArr.map {"#\($0)"}.joined(separator: " ") }
        for image in inputImages {
            let imageWithText = textToImage(drawText: memo, inImage: image, inCGRect: CGRect(x: image.size.width / 10, y: image.size.height + (image.size.height / 2), width: image.size.width, height: image.size.height))
            temp.append(imageWithText)
            
        }
        filterOutputs = temp
    }
}
