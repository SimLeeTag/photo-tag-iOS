//
//  PhotoNoteViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/06.
//

import UIKit

final class PhotoNoteViewController: UIViewController {

    weak var coordinator: PhotoNoteCoordinator?
    
    //TODO:- add viewModel as parameter
    init(coordinator: PhotoNoteCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
