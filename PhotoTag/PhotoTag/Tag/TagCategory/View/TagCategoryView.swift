//
//  TagCategoryView.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/06.
//

import UIKit

protocol TagCategoryViewDelegate: class {
    func moveToTagManagementButtonDidTouched(_ tagCategoryView: TagCategoryView)
    func moveToPhotoListButtonDidTouched(_ tagCategoryView: TagCategoryView)
}

final class TagCategoryView: ContentViewWithHeader {
    
    enum TagCategoryViewConstant {
        static let title = "Tags"
        static let goButtonTitle = "Go"
    }
    
    // MARK: - Properties
    @UsesAutoLayout var titleLabel = SubviewFactory.titleLabel()
    @UsesAutoLayout var moveToTagManagementButton = SubviewFactory.moveToTagManagementButton()
    @UsesAutoLayout var moveToPhotoListButton = SubviewFactory.moveToPhotoListButton()
    @UsesAutoLayout var tagCategoryCollectionView = SubviewFactory.tagCategoryCollectionView()
    weak var delegate: TagCategoryViewDelegate?
    
    // MARK: - Intialization
    init() {
        super.init(frame: .zero)
        addButtonsTarget()
        addSubviews()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: - Functions
    
    private func addButtonsTarget() {
        moveToTagManagementButton.addTarget(self, action: #selector(moveToTagManagementButtonDidTouched), for: .touchUpInside)
        moveToPhotoListButton.addTarget(self, action: #selector(moveToPhotoListButtonDidTouched), for: .touchUpInside)
    }
    override func addSubviews() {
        configureHeaderView()
        configureContentStackView()
        configureContentView()
        self.addSubview(contentView)
        self.addSubview(moveToPhotoListButton)
    }
    
    override func configureHeaderView() {
        headerStackView.addArrangedSubview(spaceView)
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(moveToTagManagementButton)
    }
    
    private func configureContentStackView() {
        contentStackView.addArrangedSubview(headerStackView)
        contentStackView.addArrangedSubview(tagCategoryCollectionView)
    }
    
    override func setupLayout() {
        contentStackView.pinEdges(to: contentView)
        contentView.pinEdges(to: self)
        
        headerStackView.alignment = .bottom
        contentStackView.spacing = .ten
        
        spaceView.pinWidth(to: self.widthAnchor, multiplier: .zeroPointOne)
        moveToTagManagementButton.pinWidth(to: self.widthAnchor, multiplier: .zeroPointOneFive)
        headerStackView.pinHeight(to: self.heightAnchor, multiplier: .zeroPointOneTwo)
        headerStackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        moveToPhotoListButton.pinWidth(to: self.widthAnchor, multiplier: .zeroPointEightfive)
        moveToPhotoListButton.pinHeight(to: self.heightAnchor, multiplier: .zeroPointZerofive)
        moveToPhotoListButton.pinCenterX(to: self.centerXAnchor)
        moveToPhotoListButton.pinBottom(to: self.bottomAnchor, offset: -.twenty)
    }
    
    @objc private func moveToTagManagementButtonDidTouched() {
        delegate?.moveToTagManagementButtonDidTouched(self)
    }
    
    @objc private func moveToPhotoListButtonDidTouched() {
        delegate?.moveToPhotoListButtonDidTouched(self)
    }
    
}

private extension TagCategoryView {
    
    struct SubviewFactory {
        
        static func titleLabel() -> UILabel {
            let label = UILabel()
            label.text = TagCategoryViewConstant.title
            label.font = UIFont.boldSystemFont(ofSize: .twenty)
            label.textAlignment = .left
            return label
        }
        
        static func moveToTagManagementButton() -> UIButton {
            let button = UIButton()
            button.setTitleColor(.darkGray, for: .normal)
            button.setImage(.filter, for: .normal)
            button.tintColor = .darkGray
            return button
        }
        
        static func moveToPhotoListButton() -> UIButton {
            let button = UIButton()
            button.setTitle(TagCategoryViewConstant.goButtonTitle, for: .normal)
            button.clipsToBounds = false
            button.layer.cornerRadius = .ten
            button.backgroundColor = UIColor.keyColorInLightMode
            button.setTitleColor(.white, for: .normal)
            return button
        }
        
        static func tagCategoryCollectionView() -> UICollectionView {
            let layout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(cellType: TagCategoryCollectionViewCell.self)
            return collectionView
        }
        
    }
    
}
