//
//  PhotoNotes.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/12/17.
//

import Foundation

struct Note: Codable {
    let tagID, noteID: Int
    let tags, photos: [String]
    let created: Date
    let rawMemo: String
    
    enum CodingKeys: String, CodingKey {
        case tags, photos, created, rawMemo
        case tagID = "tagId"
        case noteID = "noteId"
    }
}
