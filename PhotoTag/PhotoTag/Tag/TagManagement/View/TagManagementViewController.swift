//
//  TagManagementViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/27.
//

import UIKit

enum TagManagementTableViewConstant {
    static let numberOfSections = 2
    static let activeHashtagsSectionNumber = 0
    static let activeHashtagsSectionHeaderTitle = "Active Hashtags  (Swipe to edit)"
    static let archivedHashtagsSectionHeaderTitle = "Archived Hashtags"
}

class TagManagementViewController: UIViewController {
    
    // MARK: - Properties
    private let dataSource = TagManagementTableViewDataSource()
    weak var coordinator: TagCoordinator?
    private var tagManagementView: TagManagementView! {
        return view as? TagManagementView
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
        view = TagManagementView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Functions
    private func configure () {
        hideNavigationBar()
        tagManagementView.backButton.addTarget(self, action: #selector(navigateToTagCategory), for: .touchUpInside)
        tagManagementView.hashtagTableView.dataSource = dataSource
    }
    
    private func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func navigateToTagCategory() {
        self.navigationController?.popViewController(animated: true)
    }
}
