//
//  TagCategoryCollectionViewDataSource.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/11.
//

import UIKit

final class TagCategoryCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var viewModel = TagCategoryViewModel()
    private let imageLoadTaskManager = ImageDownloadManager()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return TagCategoryCollectionViewConstant.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tags.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(with: TagCategoryCollectionViewCell.self, for: indexPath)
        bind(with: collectionViewCell)
        let tagInCurrentPosition = indexPath.item
        if !viewModel.tags.value.isEmpty && !viewModel.tagImageUrls.value.isEmpty {
            let id = viewModel.tags.value[tagInCurrentPosition].tagID
            collectionViewCell.updateTagId(id)
            collectionViewCell.fill(with: self.viewModel.tags.value[tagInCurrentPosition])
            viewModel.fetchTagImage(with: viewModel.tagImageUrls.value[tagInCurrentPosition]) { cellImage in
                collectionViewCell.fillImage(with: cellImage)
            }
        }
        collectionViewCell.backgroundColor = .black
        return collectionViewCell
    }
    
}

extension TagCategoryCollectionViewDataSource {
    func updateViewModel(updatedViewModel: TagCategoryViewModel) {
        self.viewModel = updatedViewModel
    }
    
    private func bind(with cell: TagCategoryCollectionViewCell) {
        let cellViewModel = TagCategoryCellViewModel()
        cellViewModel.noteCountLabelText.bind { noteCount in
            cell.noteCountLabel.text = "\(noteCount)"
        }
        cellViewModel.tagNameLabelText.bind { tagName in
            cell.tagNameLabel.text = tagName
        }
        cellViewModel.image.bind { image in
            cell.latestImageView.image = image
        }
    }
}
