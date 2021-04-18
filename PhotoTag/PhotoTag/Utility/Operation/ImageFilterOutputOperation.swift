//
//  ImageFilterOutputOperation.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/04/15.
//

import UIKit

// define the content for the operation image needs in the abstract class
class ImageFilterOutputOperation: ImageFilterOperation {
    
    fileprivate let completion: ([UIImage]?) -> Void
    init(completion: @escaping ([UIImage]?) -> Void) {
        self.completion = completion
        
        // for now, objectize without image first
        super.init(images: nil, textArr: nil)
    }
    
    override func main() {
        if isCancelled { return }
        completion(filterInputs)
    }
}
