//
//  PhotoNote.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/01/20.
//

import Foundation

struct PhotoNote: Codable {
    let created: String
    let noteID: Int
    let photos: [String]
    let rawMemo: String
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case created
        case noteID = "noteId"
        case photos, rawMemo, tags
    }
}
