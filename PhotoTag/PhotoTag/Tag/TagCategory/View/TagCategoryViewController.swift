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
        tagCategoryView.tagCategoryCollectionView.dataSource = self
    }
    
    private func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func navigateToTagManagement() {
        coordinator?.navigateToTagManagement()
    }
    
    @objc func navigateToPhotoNoteList() {
        coordinator?.parentCoordinator?.navigateToPhotoNoteList()
    }
}
extension TagCategoryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return TagCategoryCollectionViewConstant.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 150 // 추후 변경 예정입니다.
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(with: TagCategoryCollectionViewCell.self, for: indexPath)
        return collectionViewCell
    }
}
