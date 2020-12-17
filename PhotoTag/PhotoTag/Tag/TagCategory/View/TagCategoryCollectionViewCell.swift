//
//  TagCategoryCollectionViewCell.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/10.
//

import UIKit

final class TagCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var latestImageView: UIImageView!
    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var noteCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
