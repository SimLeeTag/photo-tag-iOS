//
//  TagManagementTableViewCell.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/11.
//

import UIKit

class TagManagementTableViewCell: UITableViewCell {

    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var noteCountLabel: UILabel!
    private var viewModel: TagManagementCellViewModel!
    private(set) var tagId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fill(with hashtag: Hashtag) {
        tagNameLabel.text = hashtag.tagName
        noteCountLabel.text = "\(hashtag.frequency) note(s)"
        tagId = hashtag.tagID
    }
    
}
