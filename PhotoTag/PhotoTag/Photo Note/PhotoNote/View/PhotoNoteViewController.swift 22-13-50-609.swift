//
//  PhotoNoteViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/06.
//

import UIKit
import YPImagePicker

class PhotoNoteViewController: UIViewController {

    weak var coordinator: PhotoNoteCoordinator?
    let viewModel: PhotoNoteViewModel
    
    init(coordinator: PhotoNoteCoordinator, viewModel: PhotoNoteViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
