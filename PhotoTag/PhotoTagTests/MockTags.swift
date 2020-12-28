//
//  MockTags.swift
//  PhotoTagTests
//
//  Created by Keunna Lee on 2020/12/18.
//

import Foundation

struct MockTags {
    
    private(set) var tagIdIndex = 0
    private(set) var frequencyIndex = 0
    private(set) var tagNameIndex = 0
    private(set) var imageUrlIndex = 0
    let tagIdList = [11, 13, 21, 41, 8, 3, 5, 33]
    let frequencyList = [5, 11, 8, 10, 0, 4, 1, 2]
    let tagNameList = ["travel", "career", "winter", "workOut", "nothing", "journey", "iceland", "winter"]
    let imageUrls = ["https://cdn.pixabay.com/photo/2020/11/22/16/45/nutcracker-5767159_1280.jpg", "https://cdn.pixabay.com/photo/2019/12/19/10/56/christmas-market-4705882_1280.jpg", "https://cdn.pixabay.com/photo/2017/01/28/02/24/japan-2014619_1280.jpg","https://cdn.pixabay.com/photo/2017/10/10/21/49/youtuber-2838945_1280.jpg","https://cdn.pixabay.com/photo/2015/03/21/13/09/men-683660_1280.jpg","https://cdn.pixabay.com/photo/2015/12/16/03/45/korea-1095361_1280.jpg","https://cdn.pixabay.com/photo/2016/10/25/12/28/iceland-1768744_1280.jpg", "https://media.istockphoto.com/photos/reykjavik-capital-city-of-iceland-picture-id825428482", "https://cdn.pixabay.com/photo/2019/12/19/10/56/christmas-market-4705882_1280.jpg"]
    let tags = [Tag]()
    
    mutating func makeMokeTags() -> [Tag] {
        return [newTag(),newTag(),newTag(),newTag(),newTag(),newTag(),newTag(),newTag()]
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
    
    private func nextImageUrl() -> String {
        return imageUrls[imageUrlIndex]
    }
    
    private mutating func newTag() -> Tag {
        let newTag = Tag(thumbnail: nextImageUrl(), frequency: nextFrequencyValue(), tagID: nextTagIdValue(), activated: true, tagName: nextTagName())
        self.tagIdIndex = tagIdIndex + 1
        self.frequencyIndex = frequencyIndex + 1
        self.tagNameIndex = tagNameIndex + 1
        self.imageUrlIndex = imageUrlIndex + 1
        return newTag
    }
}
