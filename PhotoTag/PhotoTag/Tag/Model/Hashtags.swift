//
//  Hashtag.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/25.
//

import Foundation

struct Hashtags: Codable {
    let activatedList, archivedList: [Hashtag]
}

// MARK: - EdList
struct Hashtag: Codable {
    let activated: Bool
    let frequency, tagID: Int
    let tagName: String
    
    enum CodingKeys: String, CodingKey {
        case activated, frequency
        case tagID = "tagId"
        case tagName
    }
}
