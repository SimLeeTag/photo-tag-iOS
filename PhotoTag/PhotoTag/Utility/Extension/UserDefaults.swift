//
//  UserDefaults.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/03/28.
//

import UIKit

extension UserDefaults {
    func imageArray(forKey key: String) -> [UIImage]? {
        guard let array = self.array(forKey: key) as? [Data] else {
            return nil
        }
        return array.flatMap() { UIImage(data: $0) }
    }

    func set(_ imageArray: [UIImage], forKey key: String) {
        self.set(imageArray.flatMap({ $0.pngData() }), forKey: key)
    }
}
