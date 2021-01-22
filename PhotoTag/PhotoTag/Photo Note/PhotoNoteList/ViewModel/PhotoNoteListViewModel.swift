//
//  PhotoNoteListViewModel.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/01/21.
//

import Foundation

class PhotoNoteListViewModel {
    
    let noteNetworkingManager = NoteNetworkingManager()
    var selectedTags: [TagID] = []
    var firstSelectedTagText = Observable("")
    var secondSelectedTagText = Observable("")
    var thirdSelectedTagText = Observable("")
    private(set) var photoNoteList: Observable<[PhotoNote]> = Observable([])

    init() {
        self.selectedTags = takeTagIdsOut() // bring seleted tag ids stored in UserDefaults
    }
    
    private func takeTagIdsOut() -> [Int] {
        let noTagId = 4
        guard let selectedTagIds = UserDefaults.standard.array(forKey: UserDefaultKey.selectedTagIds) as? [Int] else { return [noTagId] }
        return selectedTagIds
    }
    
    func fetchPhotoNoteList(completionHandler: @escaping ([PhotoNote]?) -> Void) {
        noteNetworkingManager.fetchNoteList(tagIds: selectedTags) { photoList in
            guard let allPhotoList = photoList else { return }
            self.photoNoteList.value = allPhotoList
            self.firstSelectedTagText.value = self.photoNoteList.value[0].tags[0]
            self.secondSelectedTagText.value = self.photoNoteList.value[1].tags[0]
            self.thirdSelectedTagText.value = self.photoNoteList.value[2].tags[0]
            completionHandler(allPhotoList)
        }
    }
}
