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
    private let viewModel: TagCategoryViewModel
    private let requestTagDataSize = 12
    private var requestTime = 0
    private var requestTagDataPageNumber: Int { return requestTagDataSize * requestTime }
    private var viewAppeared = false
    private var tagImageHeights: [CGFloat] = []
    private var tagCategoryView: TagCategoryView! { return view as? TagCategoryView  }
    private var selectedTagIds: [Int] = [] {
        didSet {
            if selectedTagIds.count > 0 || selectedTagIds.count > 3 {
                activateButton()
            } else {
                deactivateButton()
            }
        }
    }
    
    // MARK: - Intialization
    //TODO:- add viewModel as parameter
    init(with viewModel: TagCategoryViewModel, coordinator: TagCoordinator) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: - Life Cycle
    override func loadView() {
        view = TagCategoryView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        fetchTags()
        configure()
        viewAppeared = true
    }
    
    // MARK: - Functions
    private func configure () {
        hideNavigationBar()
        tagCategoryView.delegate = self // TagCategoryViewDelegate
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let collectionView = tagCategoryView.tagCategoryCollectionView
        collectionView.delegate = self // UICollectionViewDelegateFlowLayout
        collectionView.dataSource = dataSource
        collectionView.showsVerticalScrollIndicator = false
        if let layout = collectionView.collectionViewLayout as? TagCategoryLayout {
            layout.delegate = self // TagCategoryLayoutDelegate
            tagCategoryView.backgroundColor = .white
        }
    }
    
    private func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func updateRequestTime() {
        self.requestTime = requestTime + 1
    }
    
    private func navigateToTagManagement() {
        coordinator?.navigateToTagManagement()
    }
    
    private func navigateToPhotoNoteList() {
        coordinator?.navigateToPhotoNoteList()
    }
    
    private func bind() {
        viewModel.title.bind { [weak self] sceneTitle in
            self?.tagCategoryView.titleLabel.text = sceneTitle
        }
    }
    
    private func fetchTags() {
        if viewAppeared {
            viewModel.fetchTags(size: requestTagDataSize,
                                page: requestTagDataPageNumber) { fetchedViewModel in
                self.dataSource.updateViewModel(updatedViewModel: fetchedViewModel)
                self.updateTags()
            }
        }
    }
    
    private func saveTagImageHeight(_ images: [UIImage]) {
        let heights = images.map {$0.size.height}
        tagImageHeights.append(contentsOf: heights)
    }
    
    private func updateTags() {
        DispatchQueue.main.async {
            self.view.layoutIfNeeded()
            self.tagCategoryView.tagCategoryCollectionView.reloadData()
        }
    }
    
    private func activateButton() {
        tagCategoryView.moveToPhotoListButton.isUserInteractionEnabled = true
        tagCategoryView.moveToPhotoListButton.backgroundColor = UIColor.keyColorInLightMode
        tagCategoryView.moveToPhotoListButton.setTitleColor(.white, for: .normal)
    }
    
    private func deactivateButton() {
        tagCategoryView.moveToPhotoListButton.isUserInteractionEnabled = false
        tagCategoryView.moveToPhotoListButton.backgroundColor = UIColor.lightGray
        tagCategoryView.moveToPhotoListButton.setTitleColor(.black, for: .normal)
    }
}

extension TagCategoryViewController: TagCategoryViewDelegate {
    func moveToTagManagementButtonDidTouched(_ tagCategoryView: TagCategoryView) {
        navigateToTagManagement()
    }
    
    func moveToPhotoListButtonDidTouched(_ tagCategoryView: TagCategoryView) {
        UserDefaults.standard.set(selectedTagIds, forKey: UserDefaultKey.selectedTagIds)
        navigateToPhotoNoteList()
    }
    
}

extension TagCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collectionViewCell = collectionView.dequeueReusableCell(with: TagCategoryCollectionViewCell.self, for: indexPath)
        self.selectedTagIds.append(collectionViewCell.tagId)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let collectionViewCell = collectionView.dequeueReusableCell(with: TagCategoryCollectionViewCell.self, for: indexPath)
        self.selectedTagIds = self.selectedTagIds.filter { $0 != collectionViewCell.tagId }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let count = collectionView.indexPathsForSelectedItems?.count else { return true }
        return count < 3
    }
}

extension TagCategoryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if viewAppeared {
            let yOffset = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            if yOffset > contentHeight - scrollView.frame.height {
                fetchTags()
                updateRequestTime()
            }
        }
    }
}

extension TagCategoryViewController: TagCategoryLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return self.viewModel.tagImages.value[indexPath.item].size.height
    }
}
