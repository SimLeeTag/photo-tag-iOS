//
//  PhotoNoteListTableViewDataSource.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/01/21.
//

import UIKit

final class PhotoNoteListTableViewDataSource: NSObject, UITableViewDataSource {
    
    var noteList = [PhotoNote]()
    let imageLoadTaskManager = ImageDownloadManager()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if noteList[indexPath.item].photos.count < 3 {
            return makeOneImageTypeCell(tableView, cellForRowAt: indexPath)
        }
        return makeThreeImageTypeCell(tableView, cellForRowAt: indexPath)
    }
    
}

extension PhotoNoteListTableViewDataSource {
    
    func updatePhotoNoteList(_ photoNoteList: [PhotoNote]) {
        self.noteList = photoNoteList
    }
    
    private func makeOneImageTypeCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> PhotoNoteListOneImageTableViewCell {
        // note data that should be in appropriate indexPath
        let note = noteList[indexPath.item]

        // fill data except image first
        let tableViewCell = tableView.dequeueReusableCell(with: PhotoNoteListOneImageTableViewCell.self, for: indexPath)
        tableViewCell.fill(with: note)
        
        // fetch and fill image in cell
        guard let imageUrl = URL(string: note.photos[0]) else { return PhotoNoteListOneImageTableViewCell()}
        imageLoadTaskManager.fetchImage(with: imageUrl) { image in
            tableViewCell.fillImage(with: image)
            
            // if one images in cell, hidden +1 label
            if self.noteList[indexPath.item].photos.count == 1 {
                tableViewCell.leftImageCountLabel.isHidden = true
            }
        }
        
        // update note ID in cell
        tableViewCell.updateNoteId(noteList[indexPath.item].noteID)
        
        // no effect when cell is selected
        DispatchQueue.main.async { tableViewCell.selectionStyle = .none }
        return tableViewCell
    }
    
    private func makeThreeImageTypeCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> PhotoNoteListThreeImageTableViewCell {
        // note data that should be in appropriate indexPath
        let note = noteList[indexPath.item]
        
        // fill data except images first
        let tableViewCell = tableView.dequeueReusableCell(with: PhotoNoteListThreeImageTableViewCell.self, for: indexPath)
        tableViewCell.fill(with: note)
        
        // fetch and fill images in cell
        var imageURLs: [String] = []
        var images: [UIImage?] = []
        for index in 0..<3 {
            imageURLs.append(note.photos[index])
        }
        
        for url in imageURLs {
            guard let imageUrl = URL(string: url) else { return PhotoNoteListThreeImageTableViewCell()}
            imageLoadTaskManager.fetchImage(with: imageUrl) { image in
                images.append(image)
                
                // after fetch all the images to display in cell, fill those images in cell
                if images.count == 3 {
                    tableViewCell.fillImages(with: images)
                }
            }
        }
        // update note ID in cell
        tableViewCell.updateNoteId(noteList[indexPath.item].noteID)
        
        // no effect when cell is selected
        DispatchQueue.main.async { tableViewCell.selectionStyle = .none }
        return tableViewCell
    }
}
