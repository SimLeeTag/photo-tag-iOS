//
//  PhotoImageView.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/04/09.
//

import UIKit

final class PhotoImageView: UIImageView {
    
    // MARK: - Properties
    var isLoading: Bool {
      get { return activityIndicator.isAnimating }
      set {
        if newValue {
          activityIndicator.startAnimating()
        } else {
          activityIndicator.stopAnimating()
        }
      }
    }
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        self.addSubview(indicator)
        indicator.pinCenter(to: self)
        return indicator
    }()
    var lastImgUrl: String?
    
    // MARK: - Functions
    func loadImage(with urlString: String) {
        
        self.image = nil
        lastImgUrl = urlString
        
        // Check cached image first
        if let cachedImage = ImageCache.shared.cacheDic[urlString] {
            self.image = cachedImage
            self.isLoading = false
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        ImageDownloadManager.fetchImage(with: url) { [weak self] photoImage in
            ImageCache.shared.cacheDic[url.absoluteString] = photoImage
            self?.updateImage(with: photoImage)
        }
    }
    
    func updateImage(with image: NoteImage?) {
        DispatchQueue.main.async {
            self.image = image
            self.isLoading = false
        }
    }
    
}
