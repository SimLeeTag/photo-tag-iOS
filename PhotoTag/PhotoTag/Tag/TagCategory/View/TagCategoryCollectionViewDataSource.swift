//
//  TagCategoryCollectionViewDataSource.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/11.
//

import UIKit

final class TagCategoryCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var viewModel = TagCategoryViewModel()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return TagCategoryCollectionViewConstant.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tags.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(with: TagCategoryCollectionViewCell.self, for: indexPath)
        bind(with: collectionViewCell)
        if viewModel.tags.value.count != 0, self.viewModel.tagImages.value.count != 0 {
            collectionViewCell.fill(with: self.viewModel.tags.value[indexPath.item])
            collectionViewCell.fillImage(with: self.viewModel.tagImages.value[indexPath.item])
        }
        return collectionViewCell
    }
    
}

extension TagCategoryCollectionViewDataSource {
    func updateViewModel(updatedViewModel: TagCategoryViewModel) {
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
