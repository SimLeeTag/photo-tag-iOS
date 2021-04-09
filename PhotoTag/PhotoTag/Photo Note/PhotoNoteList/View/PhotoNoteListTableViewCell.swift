//
//  PhotoNoteListTableViewCell.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/04/09.
//

import UIKit

class PhotoNoteListTableViewCell: UITableViewCell, NoteListCell {

    var noteId: NoteID = 0
    var urls: [String]? {
        didSet {
            if let urls = urls { fillImages(with: urls)  }
        }
    }
    lazy private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy private var scrollview: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    lazy private var dateLabel = newLabel()
    lazy private var memoLabel = newLabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        stackView.pinEdges(to: self, edgeInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        stackView.addSubview(scrollview)
        stackView.addSubview(dateLabel)
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        stackView.addSubview(memoLabel)
    }
    
    func fill(with note: PhotoNote) {
        DispatchQueue.main.async {
            self.dateLabel.text = note.created
            self.noteId = note.noteID
            self.urls = note.photos
            self.highlightTag(note.tags) // show tags only
        }
    }
    
    private func highlightTag(_ tags: [String]) {
        let tags = tags.map({"#\($0)"})
        DispatchQueue.main.async {
            guard let labelText = self.memoLabel.text else { return }
            let attributedStr = NSMutableAttributedString(string: labelText)
            for tag in tags {
                attributedStr.addAttribute(.foregroundColor, value: UIColor.keyColorInLightMode, range: (labelText as NSString).range(of: "\(tag)"))
            }
            self.memoLabel.attributedText = attributedStr
        }
    }
    
    func fillImages(with urls: [String]) {
        for i in 0..<urls.count {
            guard let url = URL(string: urls[i])?.absoluteString else { return }
            let imageView = newImageView()
            self.addSubview(imageView)
            imageView.isLoading = true
            imageView.loadImage(with: url)
            
            let xPosition = self.scrollview.frame.width * CGFloat(i)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.scrollview.frame.width, height: self.scrollview.frame.height)
            imageView.center = .init(x: self.scrollview.frame.width / 2 + xPosition, y: scrollview.frame.height / 2)
            
            scrollview.contentSize.width = scrollview.frame.width * CGFloat(i + 1)
            scrollview.addSubview(imageView)
        }
    }
}

extension PhotoNoteListTableViewCell {
    private func newImageView() -> PhotoImageView {
        let imageView = PhotoImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    private func newLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
}
