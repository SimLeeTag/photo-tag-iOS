//
//  PhotoNoteImageProvider.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/04/15.
//

import UIKit

class PhotoNoteImageProvider {
    fileprivate let operationQueue = OperationQueue()
    
    let note: PhotoNote
    let imgUrls: [String]
    
    init(note: PhotoNote, completion: @escaping ([UIImage]?) -> Void) {
        self.note = note
        self.imgUrls = note.photos
        
        let dataLoad = DataLoadOperation(imageUrlStrs: imgUrls)
        let filterApplied = PhotoNoteOperation(images: nil, textArr: note.tags)
        let filterOutput = ImageFilterOutputOperation(completion: completion)
        
        let operations = [dataLoad, filterApplied, filterOutput]
        
        filterApplied.addDependency(dataLoad)
        filterOutput.addDependency(filterApplied)
        
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
    
    func cancel() {
        operationQueue.cancelAllOperations()
    }
}

extension PhotoNoteImageProvider: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(note)
        hasher.combine(imgUrls)
    }
}

func ==(lhs: PhotoNoteImageProvider, rhs: PhotoNoteImageProvider) -> Bool {
    return lhs.note == rhs.note
}
