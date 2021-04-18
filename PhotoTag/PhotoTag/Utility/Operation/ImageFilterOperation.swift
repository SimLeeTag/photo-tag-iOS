//
//  ImageFilterOperation.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/04/15.
//

import UIKit

protocol ImageFilterDataProvider {
    var images: [UIImage]? { get }
}

// abstract class (input - output)
class ImageFilterOperation: Operation {
    
    let textArr: [String]?
    var filterOutputs: [UIImage]?
    fileprivate let _filterInputs: [UIImage]?
    
    /* create "_filterInput ===>
     (1.Image created or 2.Image extracted based on dependency (Operation) "filterInput"*/
    init(images: [UIImage]?, textArr: [String]?) {
        _filterInputs = images
        self.textArr = textArr
        super.init()
    }
    
    var filterInputs: [UIImage]? {
        var images: [UIImage]?
        
        // (1) if there is an image in "_filterInput", put it in "image" ===> "filterInput"
        if let inputImages = _filterInputs {
            images = inputImages
            
        // (2) image data from "ImageFilterDataProvider" based on dependence ===> "filterInput"
        } else if let dataProvider = dependencies
            .filter({ $0 is ImageFilterDataProvider })
            .first as? ImageFilterDataProvider {
            images = dataProvider.images
        }
        return images
    }
}

// adopting protocols for dependancy
extension ImageFilterOperation: ImageFilterDataProvider {
    var images: [UIImage]? {
        return filterOutputs
    }
}
