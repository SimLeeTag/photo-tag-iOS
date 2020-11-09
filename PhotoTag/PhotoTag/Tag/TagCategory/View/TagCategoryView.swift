//
//  TagCategoryView.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/06.
//

import UIKit

class TagCategoryView: ScrollableContentViewWithHead {
    
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
        contentStackView.addArrangedSubview(tagCategoryTableView)
        contentStackView.addArrangedSubview(moveToPhotoListButton)
        configureContentView()
    }
    
    override func configureHeaderView() {
        headerStackView.addArrangedSubview(spaceView)
        headerStackView.addArrangedSubview(moveToTagManagementButton)
        headerStackView.addArrangedSubview(headerStackView)
    }
    
    override func setupLayout() {
        spaceView.pinWidth(to: self.widthAnchor, multiplier: 0.95)
        headerStackView.pinHeight(to: self.heightAnchor, multiplier: 0.1)
        moveToTagManagementButton.pinHeight(to: self.heightAnchor, multiplier: 0.15)
        contentView.pinEdges(to: scrollView)
        scrollView.pinEdges(to: self, edgeInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
}

private extension TagCategoryView {
    struct SubviewFactory {
        
        static func moveToTagManagementButton() -> UIButton {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: "plus.slash.minus"), for: .normal)
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
