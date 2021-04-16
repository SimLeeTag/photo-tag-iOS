//
//  PhotoNote.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/01/20.
//

import Foundation

struct PhotoNote: Codable {
    let noteID: Int
    let tags: [String]
    let created, rawMemo: String
    let photos: [String]

    enum CodingKeys: String, CodingKey {
        case noteID = "noteId"
        case tags, created, rawMemo, photos
    }
}
// to enable PhotoNoteImageProvider to adopt Hashable protocol
extension PhotoNote: Hashable {}
