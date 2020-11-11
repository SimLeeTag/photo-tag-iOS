//
//  TagManagementViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/27.
//

import UIKit

class TagManagementViewController: UIViewController {
    
    enum TagManagementTableViewConstant {
        static let numberOfSections = 2
        static let activeHashtagsSectionNumber = 0
        static let activeHashtagsSectionHeaderTitle = "Active Hashtags  (Swipe to edit)"
        static let archivedHashtagsSectionHeaderTitle = "Archived Hashtags"
        static let tableViewCellIdentifier = "tableViewCellIdentifier"
    }
    
    // MARK: - Properties
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
    
    private func configure () {
        hideNavigationBar()
        tagManagementView.backButton.addTarget(self, action: #selector(navigateToTagCategory), for: .touchUpInside)
        tagManagementView.hashtagTableView.dataSource = self
    }
    
    // MARK: - Functions
    private func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func navigateToTagCategory() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension TagManagementViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        TagManagementTableViewConstant.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionTitle = ""
        if section == TagManagementTableViewConstant.activeHashtagsSectionNumber {
            sectionTitle = TagManagementTableViewConstant.activeHashtagsSectionHeaderTitle
        } else {
            sectionTitle = TagManagementTableViewConstant.archivedHashtagsSectionHeaderTitle
        }
        return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5 // 추후 변경 예정입니다.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TagManagementTableViewConstant.tableViewCellIdentifier, for: indexPath) as? TagManagementTableViewCell else { return UITableViewCell() }
        return cell
    }
    
}
