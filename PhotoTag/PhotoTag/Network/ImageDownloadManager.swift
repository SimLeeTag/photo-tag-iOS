//
//  ImageLoadTaskManager.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/12/17.
//

import Foundation
import Combine
import UIKit.UIImage

final class ImageDownloadManager {
    
    static let userQueue = DispatchQueue.global(qos: .userInitiated)
    
    static func fetchImageGroup(imageUrls: [String], completionHandler: @escaping ([UIImage]) -> Void) {
        let group = DispatchGroup()
        var downloadedImages: [NoteImage] = []
        for urlString in imageUrls {
            guard let url = URL(string: urlString) else { continue }
            group.enter()
            
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                
                defer { group.leave()}
                if error == nil, let data = data, let image = UIImage(data: data) {
                    downloadedImages.append(image)
                    self.cacheImages(url: url, image: image)
                }
            }
            task.resume()
        }
        
        group.notify(queue: self.userQueue) {
            completionHandler(downloadedImages)
        }
    }
    
    static func cacheImages(url: URL, image: NoteImage) {
            ImageCache.shared.cacheDic[url.absoluteString] = image
    }
    
    static func fetchImage(with imageURL: URL, completionHandler: @escaping (NoteImage?) -> Void) {
        
        NetworkManager.shared.session.dataTask(with: imageURL) { (data, response, error) in
            guard let data = data else { print("no image data"); return }
            
            if let httpResponse = response as? HTTPURLResponse,
               (200...299).contains(httpResponse.statusCode) {
                guard let image = UIImage(data: data) else { return }
                completionHandler(image)
            } else {
                let image = #imageLiteral(resourceName: "logo") // default image
                completionHandler(image)
                print("network error: \(error?.localizedDescription)")
            }
        }.resume()
    }
}
