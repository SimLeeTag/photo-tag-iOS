//
//  TagManagementViewModel.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/25.
//

import Foundation

class TagManagementViewModel {
    
    enum TagType {
        case activated
        case archived
    }
    let tagNetworkManager  = TagNetworkManager()
    let title = Observable(TagManagementConstant.title)
    private(set) var activatedHashtags: Observable<[Hashtag]> = Observable([]) {
        didSet { updateHashtagCount(tagType: .activated) }
    }
    var archivedHashtags: Observable<[Hashtag]> = Observable([]) {
        didSet { updateHashtagCount(tagType: .archived) }
    }
    private(set) var activatedHashtagCounts: Int = 0
    private(set) var archivedHashtagCounts: Int = 0
    
    private func updateHashtagCount(tagType: TagType) {
        switch tagType {
        case .activated: activatedHashtagCounts = activatedHashtags.value.count
        case .archived: archivedHashtagCounts = activatedHashtags.value.count
        }
    }
    
    func fetchHashtags(completionHandler: @escaping (Self) -> Void) {
        tagNetworkManager.fetchHashtags { hashtags in
            guard let activatedList = hashtags?.activatedList else { return }
            guard let archievedList = hashtags?.archivedList else { return }
            self.activatedHashtags = Observable(activatedList)
            self.archivedHashtags = Observable(archievedList)
        }
    }
}
