//
//  PhotoNoteListThreeImageTableViewCell.swift
//  Pods
//
//  Created by Keunna Lee on 2021/01/20.
//

import UIKit

class PhotoNoteListThreeImageTableViewCell: UITableViewCell, NoteListCell {
    @IBOutlet weak var biggestImageView: UIImageView!
    @IBOutlet weak var rightTopImageView: UIImageView!
    @IBOutlet weak var rightbottomImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var leftImageCountLabel: UILabel!
    var noteId: NoteID = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        leftImageCountLabel.layer.cornerRadius = 5
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        biggestImageView.image = #imageLiteral(resourceName: "logo")
        rightTopImageView.image = #imageLiteral(resourceName: "logo")
        rightbottomImageView.image = #imageLiteral(resourceName: "logo")
        dateLabel.text = ""
        contentLabel.text = ""
        noteId = 0
    }
    
    func updateNoteId(_ id: Int) {
        self.noteId = id
    }
    
    func fill(with note: PhotoNote) {
        dateLabel.text = note.created.components(separatedBy: "T").first!
        contentLabel.text = note.rawMemo
        highlightTag(in: note, contentLabel)
    }
    
    func fillImages(with images: [UIImage?]) {
        DispatchQueue.main.async {
            self.biggestImageView.contentMode = .scaleAspectFill
            self.rightTopImageView.contentMode = .scaleAspectFill
            self.rightbottomImageView.contentMode = .scaleAspectFill
            self.biggestImageView.image = images[0]
            self.rightTopImageView.image = images[1]
            self.rightbottomImageView.image = images[2]
            
            if images.count > 3 {
                self.leftImageCountLabel.text = " + \(5 - images.count) "
            }
        }
    }
    
}
