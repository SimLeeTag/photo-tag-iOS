//
//  TagCategoryViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/24.
//

import UIKit

enum TagCategoryCollectionViewConstant {
    static let numberOfSections = 1
    static let activeHashtagsSectionNumber = 0
}

final class TagCategoryViewController: UIViewController {
        
    // MARK: - Properties
    private let dataSource = TagCategoryCollectionViewDataSource()
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
        tagCategoryView.delegate = self
        // TODO: - navigate to tutorial scene
        tagCategoryView.tagCategoryCollectionView.dataSource = dataSource
    }
    
    private func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func navigateToTagManagement() {
        coordinator?.navigateToTagManagement()
    }
    
    private func navigateToPhotoNoteList() {
        coordinator?.navigateToPhotoNoteList()
    }
}
extension TagCategoryViewController: TagCategoryViewDelegate {
    func moveToTagManagementButtonDidTouched(_ tagCategoryView: TagCategoryView) {
        navigateToTagManagement()
    }
    func moveToPhotoListButtonDidTouched(_ tagCategoryView: TagCategoryView) {
        navigateToPhotoNoteList()
    }
    
}
