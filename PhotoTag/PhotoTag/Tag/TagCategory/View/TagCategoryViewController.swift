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

class TagCategoryViewController: UIViewController {
        
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
        hideNavigationBar()
        // TODO: - request data from API
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Functions
    private func configure () {
        hideNavigationBar()
        tagCategoryView.moveToTagManagementButton.addTarget(self, action: #selector(navigateToTagManagement), for: .touchUpInside)
        // TODO: - navigate to tutorial scene
        tagCategoryView.moveToPhotoListButton.addTarget(self, action: #selector(navigateToPhotoNoteList), for: .touchUpInside)
        tagCategoryView.tagCategoryCollectionView.dataSource = dataSource
    }
    
    private func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func navigateToTagManagement() {
        coordinator?.navigateToTagManagement()
    }
    
    @objc func navigateToPhotoNoteList() {
        guard let tapCoordinator =  coordinator?.parentCoordinator as? AppCoordinator else { return }
        tapCoordinator.navigateToPhotoNoteList()
    }
}
