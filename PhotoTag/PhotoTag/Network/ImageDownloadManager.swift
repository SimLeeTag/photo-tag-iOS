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
    
    let userQueue = DispatchQueue.global(qos: .userInitiated)
    
    func fetchImageGroup(imageUrls: [String], completionHandler: @escaping ([UIImage]) -> Void) {
        let group = DispatchGroup()
        var downloadedImages: [UIImage] = []
        for urlString in imageUrls {
            guard let url = URL(string: urlString) else { continue }
            group.enter()
            
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                
                defer { group.leave()}
                if error == nil, let data = data, let image = UIImage(data: data) {
                    downloadedImages.append(image)
                }
            }
            task.resume()
        }
        
        group.notify(queue: self.userQueue) {
            completionHandler(downloadedImages)
        }
    }
    
    func fetchImage(with imageURL: URL, completionHandler: @escaping (UIImage?) -> Void) {
        
        NetworkManager.shared.session.dataTask(with: imageURL) { (data, response, error) in
            guard let data = data else { print("no image data"); return }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("network error: \(error?.localizedDescription)"); return }
            
            guard let image = UIImage(data: data) else { return }
            
            completionHandler(image)
        }.resume()
    }
}
