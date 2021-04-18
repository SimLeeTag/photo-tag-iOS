//
//  PhotoNoteListTableViewCell.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/04/09.
//

import UIKit

class PhotoNoteListTableViewCell: UITableViewCell, NoteListCell {
    
    var noteId: NoteID = 0
    var photoNote: PhotoNote? {
        didSet {
            if let photoNote = photoNote {
                self.fill(with: photoNote)
                self.fillImages(nil)
            }
        }
    }
    lazy private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    lazy private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    lazy private var dateLabel = newLabel()
    lazy private var memoLabel = newLabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        stackView.pinEdges(to: self, edgeInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        stackView.addSubview(scrollView)
        stackView.addSubview(dateLabel)
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        stackView.addSubview(memoLabel)
        self.bringSubviewToFront(pageControl)
    }
    
    func fill(with note: PhotoNote) {
        DispatchQueue.main.async {
            self.dateLabel.text = note.created
            self.noteId = note.noteID
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
    
    /*this method is invoked after you bring the images from caching object or by requesting to server. It means that the image is always delivered except when you first draw a new view.*/ 
    func fillImages(_ images: [UIImage]?) {
        if let images = images {
            for i in 0..<images.count {
                let imageView = newImageView()
                setupImageView(imageView, image: images[i])
                layoutImageView(imageView, i: i)
                scrollView.addSubview(imageView)
            }
            layoutScrollView(with: images.count)
        } else {  setupNoImageView() }
    }
    
    private func layoutScrollView(with imagesCount: Int) {
        scrollView.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height)
        scrollView.contentSize = CGSize(width: self.contentView.frame.width * CGFloat(imagesCount), height: self.contentView.frame.height)
        pageControl.numberOfPages = imagesCount
        pageControl.currentPage = 0
        
    }
}

// ScrollView Pagenation
extension PhotoNoteListTableViewCell {
    private func setupImageView(_ imageView: PhotoImageView, image: NoteImage) {
        imageView.isLoading = true
        imageView.updateImage(with: image)
        imageView.activityIndicator.alpha = 0.0
        imageView.activityIndicator.stopAnimating()
    }
    
    private func setupNoImageView() {
        
        let imageView = newImageView()
        imageView.image = nil
        imageView.alpha = 0
        imageView.activityIndicator.alpha = 1.0
        imageView.activityIndicator.startAnimating()
    }
    
    private func layoutImageView(_ imageView: PhotoImageView, i: Int) {
        let xPosition = self.scrollView.frame.width * CGFloat(i) 
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: xPosition, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
        imageView.center = .init(x: self.scrollView.frame.width / 2 + xPosition, y: scrollView.frame.height / 2)
        
        scrollView.contentSize.width = scrollView.frame.width * CGFloat(i + 1)
    }
}

extension PhotoNoteListTableViewCell {
    private func newImageView() -> PhotoImageView {
        let imageView = PhotoImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25.0
        imageView.layer.shadowColor = UIColor.darkGray.cgColor
        imageView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        imageView.layer.shadowRadius = 15.0
        imageView.layer.shadowOpacity = 0.9
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
