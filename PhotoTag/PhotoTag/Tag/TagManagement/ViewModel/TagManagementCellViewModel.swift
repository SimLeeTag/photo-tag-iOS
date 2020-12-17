//
//  TagManagementCellViewModel.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/29.
//

import Foundation

final class TagManagementCellViewModel {
    let tagName = Observable("hashtag")
    let noteCount = Observable(0)
}
