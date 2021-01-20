//
//  PhotoNoteListTableViewDataSource.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/01/21.
//

import UIKit

final class PhotoNoteListTableViewDataSource: NSObject, UITableViewDataSource {
    
    var noteList = [PhotoNote]()
    let imageLoadTaskManager = ImageLoadTaskManager()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = noteList[indexPath.item]
        // request image and fill it
        if noteList[indexPath.item].photos.count < 3 {
            let tableViewCell = tableView.dequeueReusableCell(with: PhotoNoteListOneImageTableViewCell.self, for: indexPath)
            tableViewCell.fill(with: note)
            guard let imageUrl = URL(string: note.photos[0]) else { return PhotoNoteListOneImageTableViewCell()}
            imageLoadTaskManager.fetchImage(with: imageUrl) { image in
                tableViewCell.fillImage(with: image)
                if self.noteList[indexPath.item].photos.count == 1 {
                    tableViewCell.leftImageCountLabel.isHidden = true
                }
            }
            tableViewCell.updateNoteId(noteList[indexPath.item].noteID)
            return tableViewCell
        }
        let tableViewCell = tableView.dequeueReusableCell(with: PhotoNoteListThreeImageTableViewCell.self, for: indexPath)
        tableViewCell.fill(with: note)
        var imageURLs: [String] = []
        var images: [UIImage?] = []
        for index in 0..<3 {
            imageURLs.append(note.photos[index])
        }
        
        for url in imageURLs {
            guard let imageUrl = URL(string: url) else { return PhotoNoteListThreeImageTableViewCell()}
            imageLoadTaskManager.fetchImage(with: imageUrl) { image in
                images.append(image)
                if images.count == 3 {
                    tableViewCell.fillImages(with: images)
                }
            }
        }
        
        tableViewCell.updateNoteId(noteList[indexPath.item].noteID)
        return tableViewCell
    }
    
}

extension PhotoNoteListTableViewDataSource {
    
    func updatePhotoNoteList(_ photoNoteList: [PhotoNote]) {
        self.noteList = photoNoteList
    }
}
