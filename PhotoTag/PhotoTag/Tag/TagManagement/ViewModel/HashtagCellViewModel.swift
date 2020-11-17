//
//  HashtagCellViewModel.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/15.
//

import Foundation

protocol HashtagCellViewModeling: class {
    var hashtagName: String { get set }
    var noteCount: Int { get set }
}

class HashtagCellViewModel: HashtagCellViewModeling {
    var hashtagName: String = ""
    var noteCount: Int = 0
}
