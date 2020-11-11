//
//  TagCategoryView.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/06.
//

import UIKit

class TagCategoryView: ContentViewWithHeader {
    
    // MARK: - Properties
    let moveToTagManagementButton = SubviewFactory.moveToTagManagementButton()
    let moveToPhotoListButton = SubviewFactory.moveToPhotoListButton()
    let tagCategoryTableView = SubviewFactory.tagCategoryTableView()
    
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
        configureContentStackView()
        configureContentView()
        self.addSubview(contentView)
        self.addSubview(moveToPhotoListButton)
    }
    
    override func configureHeaderView() {
        headerStackView.addArrangedSubview(spaceView)
        headerStackView.addArrangedSubview(moveToTagManagementButton)
    }
    
    private func configureContentStackView() {
        contentStackView.addArrangedSubview(headerStackView)
        contentStackView.addArrangedSubview(tagCategoryCollectionView)
    }
    
    override func setupLayout() {
        
        contentStackView.pinEdges(to: contentView)
        contentView.pinEdges(to: self)
        
        moveToTagManagementButton.pinWidth(to: self.widthAnchor, multiplier: 0.1)
        headerStackView.pinHeight(to: self.heightAnchor, multiplier: 0.1)
        headerStackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        moveToPhotoListButton.pinWidth(to: self.widthAnchor, multiplier: 0.85)
        moveToPhotoListButton.pinHeight(to: self.heightAnchor, multiplier: 0.05)
        moveToPhotoListButton.pinCenterX(to: self.centerXAnchor)
        moveToPhotoListButton.pinBottom(to: self.bottomAnchor, offset: -20)
    }
}

private extension TagCategoryView {
    struct SubviewFactory {
        
        static func moveToTagManagementButton() -> UIButton {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Tag Management", for: .normal)
            return button
        }
    
        static func moveToPhotoListButton() -> UIButton {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("go", for: .normal)
            button.clipsToBounds = false
            button.layer.cornerRadius = 10
            button.backgroundColor = UIColor.keyColor
            button.setTitleColor(.white, for: .normal)
            return button
        }
        
        static func tagCategoryTableView() -> UITableView {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }
        
        static func contentStackView() -> UIStackView {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.alignment = .fill
            stackView.axis = .vertical
            stackView.distribution = .fillProportionally
            stackView.spacing = 50
            return stackView
        }
        
    }
    
}
