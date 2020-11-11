//
//  TagCategoryCollectionViewDataSource.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/11.
//

import UIKit

class TagCategoryCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return TagCategoryCollectionViewConstant.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 150 // 추후 변경 예정입니다.
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(with: TagCategoryCollectionViewCell.self, for: indexPath)
        collectionViewCell.backgroundColor = .blue
        return collectionViewCell
    }
    
}
