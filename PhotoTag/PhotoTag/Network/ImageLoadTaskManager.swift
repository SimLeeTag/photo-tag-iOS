//
//  ImageLoadTaskManager.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/12/17.
//

import Foundation
import Combine
import UIKit.UIImage

final class ImageLoadTaskManager {
    
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
