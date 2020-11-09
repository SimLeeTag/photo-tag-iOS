//
//  TagCategoryViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/24.
//

import UIKit

class TagCategoryViewController: UIViewController {
    
    // MARK: - Properties
    weak var coordinator: TagCoordinator?
    private var tagCategoryView: TagCategoryView! {
        return view as? TagCategoryView
    }
    
    // MARK: - Intialization
    //TODO:- add viewModel as parameter
    init(coordinator: TagCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: - Life Cycle
    override func loadView() {
        view = TagCategoryView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Functions
    private func configure () {
        self.navigationController?.isNavigationBarHidden = true
        tagCategoryView.moveToTagManagementButton.addTarget(self, action: #selector(navigateToTagManagement), for: .touchUpInside)
        // TODO: - navigate to tutorial scene
        tagCategoryView.moveToPhotoListButton.addTarget(self, action: #selector(navigateToPhotoNoteList), for: .touchUpInside)
    }
    
    @objc func navigateToTagManagement() {
        coordinator?.navigateToTagManagement()
    }
    
    @objc func navigateToPhotoNoteList() {
        coordinator?.parentCoordinator?.navigateToPhotoNoteList()
    }
}
