//
//  PhotoNoteListTableViewCell.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/01/20.
//
import UIKit

class PhotoNoteListOneImageTableViewCell: UITableViewCell, NoteListCell {

    @IBOutlet weak var noteImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var leftImageCountLabel: UILabel!
    private(set) var noteId: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        leftImageCountLabel.layer.cornerRadius = 5
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        noteImageView.image = #imageLiteral(resourceName: "logo")
        leftImageCountLabel.text = ""
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
    
    func fillImage(with image: UIImage?) {
        DispatchQueue.main.async {
            self.noteImageView.contentMode = .scaleToFill
            if image == nil {
                self.noteImageView.image = #imageLiteral(resourceName: "logo") // if there is no image, set default image
            }
            self.noteImageView.image = image
        }
    }
    
}
