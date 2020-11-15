//
//  PhotoNoteListView.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/10.
//

import UIKit

// 임시 구현 상태입니다. 추후 리팩토링 예정입니다.

class PhotoNoteListView: ContentViewWithHeader {
    
    // MARK: - Properties
    @UsesAutoLayout var moveToTagCategoryButton = SubviewFactory.moveToTagCategoryButton()
    @UsesAutoLayout var moveToSelectPhotoButton = SubviewFactory.moveToSelectPhotoButton()
    @UsesAutoLayout var searchButton = SubviewFactory.searchButton()
    @UsesAutoLayout var selectedTagsStackView = SubviewFactory.selectedTagsStackView()
    @UsesAutoLayout var firstTagLabel = SubviewFactory.tagLabel()
    @UsesAutoLayout var secondTagLabel = SubviewFactory.tagLabel()
    @UsesAutoLayout var thirdTagLabel = SubviewFactory.tagLabel()
    
    // MARK: - Intialization
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: - Functions
    override func addSubviews() {
        configureHeaderView()
        configureContentView()
        self.addSubview(contentView)
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
        contentView.addSubview(moveToTagCategoryButton)
        contentView.addSubview(moveToSelectPhotoButton)
    }
    
    override func setupLayout() {
        contentView.pinEdges(to: self)
        headerStackView.alignment = .fill
        headerStackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        headerStackView.pinTop(to: self.safeAreaLayoutGuide.topAnchor, offset: .twenty)
        headerStackView.pinLeading(to: contentView.leadingAnchor, offset: .ten)
        headerStackView.pinTrailing(to: contentView.trailingAnchor, offset: .ten)
        
        moveToTagCategoryButton.pinLeading(to: self.leadingAnchor, offset: .ten)
        moveToTagCategoryButton.pinTrailing(to: self.trailingAnchor, offset: -.ten)
        moveToTagCategoryButton.pinHeight(to: self.heightAnchor, multiplier: .zeroPointOne)
        moveToTagCategoryButton.pinCenter(to: self)
        
        moveToSelectPhotoButton.pinLeading(to: self.leadingAnchor, offset: .ten)
        moveToSelectPhotoButton.pinTrailing(to: self.trailingAnchor, offset: -.ten)
        moveToSelectPhotoButton.pinTop(to: moveToTagCategoryButton.bottomAnchor, offset: .twenty)
        moveToSelectPhotoButton.pinHeight(to: self.heightAnchor, multiplier: .zeroPointOne)
        
        selectedTagsStackView.pinWidth(to: self.widthAnchor, multiplier: .zeroPointEight)
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
        
        static func moveToTagCategoryButton() -> UIButton {
            let button = UIButton(type: .system)
            button.backgroundColor = .blue
            button.setTitle("go to tag Category", for: .normal)
            button.tintColor = .white
            button.layer.cornerRadius = 5
            button.clipsToBounds = true
            return button
        }
        
        static func moveToSelectPhotoButton() -> UIButton {
            let button = UIButton(type: .system)
            button.backgroundColor = .blue
            button.setTitle("select Photo Button", for: .normal)
            button.tintColor = .white
            button.layer.cornerRadius = 5
            button.clipsToBounds = true
            return button
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
