//
//  PhotoNoteListViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/26.
//

import UIKit

// 리팩토링 예정입니다.

class PhotoNoteListViewController: UIViewController {
    
    weak var coordinator: PhotoNoteCoordinator? // show tag category create new note
    private var photoNoteListView: PhotoNoteListView! {
        return view as? PhotoNoteListView
    }
    
    //TODO: - add right tap gestrue to navigate to tag category
    //TODO: - add left tap gestrue to navigate to select photo
    
    // MARK: - Intialization
    //TODO:- add viewModel as parameter
    init(coordinator: PhotoNoteCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: - Life Cycle
    override func loadView() {
        view = PhotoNoteListView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // TODO: - request data from API
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Functions
    private func configure () {
        hideNavigationBar()
        photoNoteListView.moveToTagCategoryButton.addTarget(self, action: #selector(navigateToTagCategory), for: .touchUpInside)
        photoNoteListView.moveToSelectPhotoButton.addTarget(self, action: #selector(navigateToSelectPhoto), for: .touchUpInside)
    }
    
    private func hideNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc func navigateToTagCategory() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func navigateToSelectPhoto() {
        coordinator?.navigateToSelectPhoto()
    }
}
