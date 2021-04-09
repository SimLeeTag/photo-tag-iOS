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
    var date: Observable<String?> = Observable("")
    var noteId: Observable<NoteID>  = Observable(0)
    var noteContentText: Observable<NoteText> = Observable("")
    var noteImageUrls: Observable<[String]> =  Observable([""])
    
    init(with selectedItems: [NoteImage], noteId: NoteID) {
        self.selectedImages.value = selectedItems
        self.noteId.value = noteId
    }
    
    func updateSelectedImages(with images: [NoteImage]) {
        selectedImages.value = images
    }
    
    func fetchNoteContent(completionHandler: @escaping (PhotoNote) -> Void) {
        noteNetworkingManager.fetchNote(noteId: noteId.value) { photoNote in
            guard let photoNote = photoNote else { return }
            completionHandler(photoNote)
        }
    }
    
    // MARK: - After fetch note data, save and send notification
    func storeFetchedNote(photoNote: PhotoNote) {
        defer {
            self.sendNotification()
        }
        self.date.value = "\(photoNote.created)"
        self.noteContentText.value = photoNote.rawMemo
        self.noteImageUrls.value = photoNote.photos
    }
    
    // send notification to PhotoNoteViewController to display images
    func sendNotification() {
        NotificationCenter.default.post(name: .noteImages, object: nil)
    }
    
    func fetchImage(url: String, completionHandler: @escaping (NoteImage) -> Void) {
        guard let imageUrl = URL(string: url) else { return }

        ImageDownloadManager.fetchImage(with: imageUrl) { image in
            guard let image = image else { return }
            completionHandler(image)
        }
    }
    
    // MARK: - Request to Server
    func saveNewNote(completionHandler: @escaping () -> Void) {
        noteNetworkingManager.createNote(with: noteContentText.value,
                                      images: selectedImages.value) { success in
            if success { completionHandler()
            } else { print("Failed to create new note") }
        }
    }
    
    func editNote(completionHandler: @escaping () -> Void) {
        noteNetworkingManager.editNote(noteId: noteId.value, noteText: noteContentText.value) { success in
            if success ?? false { completionHandler()
            } else { print("Failed to edit note") }
        }
    }
    
    func deleteNote(completionHandler: @escaping (Bool?) -> Void) {
        noteNetworkingManager.deleteNote(noteId: noteId.value) { isSuccess in
            completionHandler(isSuccess)
        }
    }
}
