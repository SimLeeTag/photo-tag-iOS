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
    var activated: Bool
    let frequency, tagID: Int
    let tagName: String
    
    enum CodingKeys: String, CodingKey {
        case activated, frequency
        case tagID = "tagId"
        case tagName
    }
}

extension Hashtag: Equatable {
    static func == (lhs: Hashtag, rhs: Hashtag) -> Bool {
        return lhs.activated == rhs.activated && lhs.frequency == rhs.frequency && lhs.tagID == rhs.tagID && lhs.tagName == rhs.tagName
    }
}
