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
    static let cellHeight: CGFloat = 70
}

class TagManagementViewController: UIViewController {
    
    // MARK: - Properties
    private let dataSource: TagManagementTableViewDataSource
    var delegate: TagManagementTableViewDelegate?
    weak var coordinator: TagCoordinator?
    let viewModel: TagManagementViewModel
    private var tagManagementView: TagManagementView! {
        return view as? TagManagementView
    }
    
    // MARK: - Intialization
    //TODO:- add viewModel as parameter
    init(with viewModel: TagManagementViewModel, coordinator: TagCoordinator) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        dataSource = TagManagementTableViewDataSource()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: - Life Cycle
    override func loadView() {
        view = TagManagementView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchHashtags()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotification()
        bind()
        fetchHashtags()
        configure()
    }
    
    // MARK: - Functions
    private func bind() {
        viewModel.title.bind { [weak self] sceneTitle in
            self?.tagManagementView.titleLabel.text = sceneTitle
        }
        viewModel.activatedHashtags.bind { [weak self] _ in
            self?.updateHashTags()
        }
        
    }
    
    private func fetchHashtags() {
        viewModel.fetchHashtags { fetchedViewModel in
            self.dataSource.updateViewModel(updatedViewModel: fetchedViewModel)
            self.delegate?.updateViewModel(with: fetchedViewModel)
            self.updateHashTags()
        }
    }
    
    private func updateHashTags() {
        DispatchQueue.main.async {
            self.tagManagementView.hashtagTableView.reloadData()
        }
    }
    
    private func configure () {
        tagManagementView.delegate = self
        hideNavigationBar()
        tagManagementView.delegate = self
        setupTableView()
    }
    
    private func setupTableView() {
        tagManagementView.hashtagTableView.dataSource = dataSource
        tagManagementView.hashtagTableView.delegate = delegate
    }
    
    private func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func navigateToTagCategory() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension TagManagementViewController: TagManagementViewDelegate {
    func moveBackToTagCategoryButtonDidTouched(_ tagManagementView: TagManagementView) {
        navigateToTagCategory()
    }
    
}
