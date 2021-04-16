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

// Page Controll & Image Animation
extension PhotoNoteListTableViewCell: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/self.contentView.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let offset = percentOffset()
        if !scrollView.subviews.isEmpty {
            imagesWithAnimation(i: Int(pageIndex), next: Int(pageIndex) + 1, percentOffset: offset)
        }
    }
    
    private func percentOffset() -> CGPoint {
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        return percentOffset
    }
    
    private func imagesWithAnimation(i: Int, next: Int, percentOffset: CGPoint) {
        let scrollViewSubViews = scrollView.subviews
        let interval: CGFloat = CGFloat((100 / scrollViewSubViews.count - 1))
        var minimum: CGFloat = 0.0
        var maximum: CGFloat = 0.0
        for i in 0..<scrollViewSubViews.count {
            minimum = interval * CGFloat(i)
            maximum = interval * CGFloat(next)
            
            if percentOffset.x > minimum && percentOffset.x <= maximum {
                guard let imageView = scrollView.subviews[i] as? UIImageView else { return }
                guard let nextImageView = scrollView.subviews[next] as? UIImageView else { return}
                imageView.transform = CGAffineTransform(scaleX: (maximum-percentOffset.x)/interval, y: (maximum-percentOffset.x)/interval)
                nextImageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
            }
        }
    }
    
    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
        if pageControl.currentPage == 0 {
            let pageUnselectedColor: UIColor = UIColor.fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.pageIndicatorTintColor = pageUnselectedColor
            
            let bgColor: UIColor = UIColor.fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            scrollView.subviews[pageControl.currentPage].backgroundColor = bgColor
            
            let pageSelectedColor: UIColor = UIColor.fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.currentPageIndicatorTintColor = pageSelectedColor
        }
    }
}
