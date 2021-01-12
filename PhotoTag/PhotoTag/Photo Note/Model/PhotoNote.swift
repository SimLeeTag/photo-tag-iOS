//
//  PhotoNote.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/01/10.
//

import Foundation
import UIKit.UIImage

struct PhotoNote: Codable {
    let rawMemo: String
    let photos: [Data]
}
