//
//  NoteListCell.swift
//  Pods
//
//  Created by Keunna Lee on 2021/01/21.
//

import UIKit

protocol NoteListCell {
    var noteId: NoteID { get set }
    func highlightTag(in note: PhotoNote, _ contentLabel: UILabel)
    func fill(with note: PhotoNote)
    func fillImages(_ images: [UIImage]?)
}

extension NoteListCell {
    func highlightTag(in note: PhotoNote, _ contentLabel: UILabel) {
        let tags = note.tags.map({"#\($0)"})
        let font = UIFont.systemFont(ofSize: 20)

        guard let labelText = contentLabel.text else { return }
        let attributedStr = NSMutableAttributedString(string: labelText)
        for tag in tags {
            
            attributedStr.addAttribute(.foregroundColor, value: UIColor.keyColorInLightMode, range: (labelText as NSString).range(of: "\(tag)"))
        }
        contentLabel.attributedText = attributedStr
    }
}
