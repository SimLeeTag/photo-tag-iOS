//
//  ImageCache.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/04/09.
//

import UIKit.UIImage

final class ImageCache {
    static let shared: ImageCache = .init()
    var cacheDic = [ImgUrl: UIImage]()
    
    private init() { }
}
