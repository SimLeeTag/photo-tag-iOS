//
//  Tag.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/12/17.
//

import Foundation

struct Tag: Codable, Hashable {
    var thumbnail: String
    let frequency, tagID: Int
    let activated: Bool
    let tagName: String
    
    enum CodingKeys: String, CodingKey {
        case activated, frequency
        case tagID = "tagId"
        case tagName, thumbnail
    }
}
