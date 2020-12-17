//
//  Tag.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/12/17.
//

import Foundation

struct Tag: Codable {
    var thumbnailUrl: String
    let frequency, tagID: Int
    let activated: Bool
    let tagName: String
    
    enum CodingKeys: String, CodingKey {
        case frequency, tagName, activated
        case tagID = "tagId"
        case thumbnailUrl = "thumbnail"
    }
}
