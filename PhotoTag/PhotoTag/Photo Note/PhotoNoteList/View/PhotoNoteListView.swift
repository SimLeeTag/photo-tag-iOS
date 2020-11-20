//
//  PhotoNoteListView.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/10.
//

import UIKit

protocol PhotoNoteListViewDelegate: class {
    func leftSwipeDidBegin(_ photoNoteListView: PhotoNoteListView)
    func rightSwipeDidBegin(_ photoNoteListView: PhotoNoteListView)
}

class PhotoNoteListView: ContentViewWithHeader {
    
    // MARK: - Properties
    @UsesAutoLayout private(set) var searchButton = SubviewFactory.searchButton()
    @UsesAutoLayout private(set) var selectedTagsStackView = SubviewFactory.selectedTagsStackView()
    @UsesAutoLayout private(set) var firstTagLabel = SubviewFactory.tagLabel()
    @UsesAutoLayout private(set) var secondTagLabel = SubviewFactory.tagLabel()
    @UsesAutoLayout private(set) var thirdTagLabel = SubviewFactory.tagLabel()
    weak var delegate: PhotoNoteListViewDelegate?
    
    // MARK: - Intialization
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
        setupGestureRecognizer()
    }

    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: - Functions
    override func addSubviews() {
        configureHeaderView()
        configureContentView()
        self.addSubview(contentView)
    }
    
    private func setupGestureRecognizer() {
        let leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeDidBegin))
        leftSwipeGestureRecognizer.direction = .left
                self.addGestureRecognizer(leftSwipeGestureRecognizer)
        let rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeDidBegin))
        rightSwipeGestureRecognizer.direction = .right
                self.addGestureRecognizer(rightSwipeGestureRecognizer)
    }
    
    override func configureHeaderView() {
        selectedTagsStackView.addArrangedSubview(firstTagLabel)
        selectedTagsStackView.addArrangedSubview(secondTagLabel)
        selectedTagsStackView.addArrangedSubview(thirdTagLabel)
        headerStackView.addArrangedSubview(selectedTagsStackView)
        headerStackView.addArrangedSubview(searchButton)
    }
    
    override func configureContentView() {
        contentView.addSubview(headerStackView)
    }
    
    override func setupLayout() {
        contentView.pinEdges(to: self)
        headerStackView.alignment = .fill
        headerStackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        headerStackView.pinTop(to: self.safeAreaLayoutGuide.topAnchor, offset: .twenty)
        headerStackView.pinLeading(to: contentView.leadingAnchor, offset: .ten)
        headerStackView.pinTrailing(to: contentView.trailingAnchor, offset: .ten)
        selectedTagsStackView.pinWidth(to: self.widthAnchor, multiplier: .zeroPointEight)
    }
    
    @objc private func leftSwipeDidBegin() {
        delegate?.leftSwipeDidBegin(self)
    }

    @objc private func rightSwipeDidBegin() {
        delegate?.rightSwipeDidBegin(self)
    }
}

private extension PhotoNoteListView {
    
    struct SubviewFactory {
        
        static func selectedTagsStackView() -> UIStackView {
            let stackView = UIStackView()
            stackView.alignment = .leading
            stackView.axis = .vertical
            stackView.distribution = .fill
            return stackView
        }
        
        static func tagLabel() -> UILabel {
            let label = UILabel()
            label.text = "#Temporary_Tag"
            label.font = UIFont.boldSystemFont(ofSize: .twenty)
            label.textAlignment = .left
            return label
        }
        
        static func searchButton() -> UIButton {
            let button = UIButton()
            button.setImage(.search, for: .normal)
            button.clipsToBounds = false
            button.layer.cornerRadius = .ten
            button.setTitleColor(.black, for: .normal)
            return button
        }
    }
}
