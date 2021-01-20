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
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var contentStackView: UIStackView!
    private(set) var tagId: Int = 0
    override var isSelected: Bool {
        didSet {
            self.layer.cornerRadius = 5
            cellContentView.backgroundColor = isSelected ? #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1).withAlphaComponent(0.5) : .white
            self.contentView.backgroundColor = .clear
            self.backgroundColor = .clear
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        latestImageView.image = nil
        tagNameLabel.text = ""
        noteCountLabel.text = ""
        tagId = 0
    }
    
    func updateTagId(_ id: Int) {
        self.tagId = id
    }
    
    func fill(with tag: Tag) {
        tagNameLabel.text = tag.tagName
        noteCountLabel.text = "\(tag.frequency) note(s)"
    }
    
    func fillImage(with image: UIImage?) {
        DispatchQueue.main.async {
            self.latestImageView.contentMode = .scaleToFill
            if image == nil {
                self.latestImageView.image = #imageLiteral(resourceName: "logo") // if there is no image, set default image
            }
            self.latestImageView.image = image
        }
    }
    
}
