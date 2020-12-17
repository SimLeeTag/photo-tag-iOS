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
        return viewModel.tagsWithImage.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(with: TagCategoryCollectionViewCell.self, for: indexPath)
        bind(with: collectionViewCell)
        if viewModel.tagsWithImage.value.count != 0, viewModel.tagImages.value.count != 0 {
            collectionViewCell.fill(with: self.viewModel.tagsWithImage.value[indexPath.item])
            collectionViewCell.fillImage(with: self.viewModel.tagImages.value[indexPath.item])
        }
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
            cell.noteCountLabel.text = "\(noteCount) note(s)"
        }
        cellViewModel.tagNameLabelText.bind { tagName in
            cell.tagNameLabel.text = tagName
        }
        cellViewModel.latestImageViewUrl.bind { imageUrl in
            guard let url = URL(string: imageUrl) else { return }
            
            cellViewModel.updateTagImage(with: url) { image in
                cellViewModel.image.value = image
                self.viewModel.addImage(newImage: image)
            }
        }
    }
}
