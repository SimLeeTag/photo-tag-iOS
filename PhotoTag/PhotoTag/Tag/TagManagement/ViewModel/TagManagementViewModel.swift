//
//  TagManagementViewModel.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/25.
//

import Foundation

final class TagManagementViewModel {
    
    enum TagType {
        case activated
        case archived
    }
    let tagNetworkManager  = TagNetworkManager()
    let title = Observable(TagManagementConstant.title)
    private(set) var activatedHashtags: Observable<[Hashtag]> = Observable([])
    var archivedHashtags: Observable<[Hashtag]> = Observable([])
    
    func updatedHashtagCount(of tagType: TagType) -> Int {
        switch tagType {
        case .activated: return activatedHashtags.value.count
        case .archived: return archivedHashtags.value.count
        }
    }
    
    func fetchHashtags(completionHandler: @escaping (TagManagementViewModel) -> Void) {
        tagNetworkManager.fetchHashtags { hashtags in
            guard let activatedList = hashtags?.activatedList else { return }
            guard let archievedList = hashtags?.archivedList else { return }
            self.activatedHashtags = Observable(activatedList)
            self.archivedHashtags = Observable(archievedList)
            completionHandler(self)
        }
    }
    
    func updateHashtagState(tagId: Int, willBe state: TagType) {
        let tagState = state == .activated ? true : false
        if tagState { // archived -> activated
            restoreHashtag(with: tagId)
        } else { // activate -> archived
            archiveHashtag(with: tagId)
        }
        tagNetworkManager.updateHashtagActivatedState(of: tagId, with: HastagState(activated: tagState))
    }
    
    func restoreHashtag(with tagId: Int) {
        guard let tag = archivedHashtags.value.filter({ hashtag in
                                                        hashtag.tagID == tagId}).first else { return }
        activatedHashtags.value.append(tag)
        archivedHashtags.value = archivedHashtags.value.filter { hashtag in
            hashtag != tag}
    }
    
    func archiveHashtag(with tagId: Int) {
        guard let tag = activatedHashtags.value.filter({ hashtag in
                                                        hashtag.tagID == tagId}).first else { return }
        archivedHashtags.value.append(tag)
        activatedHashtags.value = activatedHashtags.value.filter { hashtag in
            hashtag != tag}
    }
    
}
