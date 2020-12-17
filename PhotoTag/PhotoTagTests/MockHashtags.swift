//
//  MockHashtags.swift
//  PhotoTagTests
//
//  Created by Keunna Lee on 2020/12/16.
//

import Foundation

struct MockHashtags {
    
    private(set) var tagIdIndex = 0
    private(set) var frequencyIndex = 0
    private(set) var tagNameIndex = 0
    let tagIdList = [11, 13, 21, 41, 8, 3]
    let frequencyList = [5, 23, 18, 10, 0, 30]
    let tagNameList = ["first", "second", "third", "fourth", "fifth", "sixth"]
    
    mutating func makeMokeHashtags() -> Hashtags {
        let activatedList = [newHashtag(with: .activated), newHashtag(with: .activated), newHashtag(with: .activated)]
        let archivedList = [newHashtag(with: .archived), newHashtag(with: .archived), newHashtag(with: .archived)]
        return Hashtags(activatedList: activatedList, archivedList: archivedList)
    }
    
    private func nextTagIdValue() -> Int {
        return tagIdList[tagIdIndex]
    }
    
    private func nextFrequencyValue() -> Int {
        return frequencyList[frequencyIndex]
    }
    
    private func nextTagName() -> String {
        return tagNameList[tagNameIndex]
    }
    
    private mutating func newHashtag(with type: TagType) -> Hashtag {
        if type == .activated {
            let hashtag = Hashtag(activated: true, frequency: nextFrequencyValue(), tagID: nextTagIdValue(), tagName: nextTagName())
            self.tagIdIndex = tagIdIndex + 1
            self.frequencyIndex = frequencyIndex + 1
            self.tagNameIndex = tagNameIndex + 1
            return hashtag
        }
        let hashtag = Hashtag(activated: false, frequency: nextFrequencyValue(), tagID: nextTagIdValue(), tagName: nextTagName())
        self.tagIdIndex = tagIdIndex + 1
        self.frequencyIndex = frequencyIndex + 1
        self.tagNameIndex = tagNameIndex + 1
        return hashtag
    }
}
