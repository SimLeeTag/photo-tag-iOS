//
//  PhotoNoteViewModel.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/12/30.
//

import Foundation
import UIKit.UIImage

class PhotoNoteViewModel {
    private(set) var selectedImages: Observable<[NoteImage]> = Observable([])
    let noteNetworkingManager = NoteNetworkingManager()
    let imageLoadTaskManager = ImageLoadTaskManager()
    var date: Observable<String?> = Observable("")
    var noteId: Observable<NoteID>  = Observable(0)
    var noteContentText: Observable<NoteText?> = Observable("")
    var noteImageUrls: Observable<[String]> =  Observable([""])
    
    init(with selectedItems: [NoteImage], noteId: NoteID) {
        self.selectedImages.value = selectedItems
        self.noteId.value = noteId
    }
    
    func fetchNoteContent(completionHandler: @escaping (PhotoNote) -> Void) {
        noteNetworkingManager.fetchNote(noteId: noteId.value) { photoNote in
            guard let photoNote = photoNote else { return }
            completionHandler(photoNote)
        }
    }
    
    func storeFetchedNote(photoNote: PhotoNote, completionHandler: @escaping() -> Void) {
        self.date.value = "\(photoNote.created)"
        self.noteContentText.value = photoNote.rawMemo
        self.noteImageUrls.value = photoNote.photos
        for url in photoNote.photos {
            fetchImages(url: url) { image in
                self.selectedImages.value.append(image)
            }
            // TODO: - fix me. should fetch all images in here and then run the handler.
            if self.selectedImages.value.count == photoNote.photos.count { completionHandler() }
        }
    }
    
    func fetchImages(url: String, completionHandler: @escaping (NoteImage) -> Void) {
        guard let imageUrl = URL(string: url) else { return }
        imageLoadTaskManager.fetchImage(with: imageUrl) { image in
            guard let image = image else { return }
            completionHandler(image)
        }
    }
}
