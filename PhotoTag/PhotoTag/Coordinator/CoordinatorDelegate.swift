//
//  CoordinatorDelegate.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/27.
//

import Foundation

protocol CoordinatorDelegate: class {
    func navigateToTagManagement()
    func navigateToPhotoNoteList()
    func navigateToTagCategory()
    func navigateToSelectPhoto()
    func navigateToPhotoNote()
    func navigateToWritePhotoNote()
}
