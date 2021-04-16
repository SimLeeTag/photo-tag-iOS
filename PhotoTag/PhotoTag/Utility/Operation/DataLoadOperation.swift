//
//  DataLoadOperation.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/04/15.
//

import Foundation
import UIKit.UIImage

class DataLoadOperation: AsyncOperation {
    
    fileprivate let imageUrlStrs: [String]
    fileprivate let completion: (([NoteImage]?) -> Void)?
    fileprivate var loadedImages: [NoteImage]?
    
    init(imageUrlStrs: [String], completion: (([NoteImage]?) -> Void)? = nil) {
        self.imageUrlStrs = imageUrlStrs
        self.completion = completion
        super.init()
    }
    
    override func main() {
        if self.isCancelled { return }
        
        // check cached images first
        checkCachedImages(imageUrlStrs) { cachedImages in
            self.loadedImages = cachedImages
            self.completion?(cachedImages)
            self.state = .finished
        }
        
        guard let loadedImages = loadedImages else { return }
        if loadedImages.count == imageUrlStrs.count { // all needed images are here
            self.completion?(images)
            return
            
        } else { // if there are short of images
            ImageDownloadManager.fetchImageGroup(imageUrls: imageUrlStrs) { [weak self] images in
                self?.loadedImages = images
                self?.completion?(images)
                self?.state = .finished
            }
        }
    }
    
    private func checkCachedImages(_ imageUrlStrs: [String], completion: ([NoteImage]) -> Void) {
        var temp: [NoteImage] = []
        for urlString in imageUrlStrs {
            if let cachedImage = ImageCache.shared.cacheDic[urlString] {
                if self.isCancelled { return }
                temp.append(cachedImage)
            }
        }
        completion(temp)
    }
}

extension DataLoadOperation: ImageFilterDataProvider {
    var images: [UIImage]? { return loadedImages }
}
