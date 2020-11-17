//
//  TagManagementViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/27.
//

import UIKit

enum TagManagementConstant {
    static let title = "Manage Hashtags"
    static let numberOfSections = 2
    static let activeHashtagsSectionNumber = 0
    static let archivedHashtagsSectionNumber = 1
    static let activeHashtagsSectionHeaderTitle = "Active Hashtags  (Swipe to edit)"
    static let archivedHashtagsSectionHeaderTitle = "Archived Hashtags"
    static let activeHashtagSwipeMenuText = "Archive"
    static let archivedHashtagSwipeMenuText = "Restore"
}

class TagManagementViewController: UIViewController {
    
    // MARK: - Properties
    private let dataSource: TagManagementTableViewDataSource
    var delegate: TagManagementTableViewDelegate?
    weak var coordinator: TagCoordinator?
    private var tagManagementView: TagManagementView! {
        return view as? TagManagementView
    }
    
    // MARK: - Intialization
    //TODO:- add viewModel as parameter
    init(coordinator: TagCoordinator) {
        self.coordinator = coordinator
        dataSource = TagManagementTableViewDataSource()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: - Life Cycle
    override func loadView() {
        view = TagManagementView()
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
        setupTableView()
        tagManagementView.backButton.addTarget(self, action: #selector(navigateToTagCategory), for: .touchUpInside)
    }
    
    private func setupTableView() {
        tagManagementView.hashtagTableView.dataSource = dataSource
        tagManagementView.hashtagTableView.delegate = delegate
    }
    
    private func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func navigateToTagCategory() {
        self.navigationController?.popViewController(animated: true)
    }
}
