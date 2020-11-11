//
//  TagManagementView.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/06.
//

import UIKit

class TagManagementView: ContentViewWithHeader {
    
    enum TagManagementViewConstant {
        static let title = "Manage Hashtags"
    }
    
    // MARK: - Properties
    let backButton = SubviewFactory.backButton()
    let titleLabel = SubviewFactory.titleLabel()
    let hashtagTableView = SubviewFactory.hashtagTableView()
    
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
    }
    
    override func configureHeaderView() {
        headerStackView.addArrangedSubview(backButton)
        headerStackView.addArrangedSubview(titleLabel)
    }
    
    private func configureContentStackView() {
        contentStackView.addArrangedSubview(headerStackView)
        contentStackView.addArrangedSubview(hashtagTableView)
    }
    
    override func setupLayout() {
        contentStackView.pinEdges(to: contentView)
        contentView.pinEdges(to: self)
        headerStackView.alignment = .bottom
        contentStackView.spacing = .ten
        titleLabel.pinWidth(to: self.widthAnchor, multiplier: .zeroPointEight)
        headerStackView.pinHeight(to: self.heightAnchor, multiplier: .zeroPointOne)
    }
}

private extension TagManagementView {
    
    struct SubviewFactory {
        
        static func backButton() -> UIButton {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(.back, for: .normal)
            button.tintColor = .black
            button.contentHorizontalAlignment = .center
            return button
        }
        
        static func titleLabel() -> UILabel {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = TagManagementViewConstant.title
            label.font = UIFont.boldSystemFont(ofSize: .twenty)
            label.textAlignment = .left
            return label
        }
        
        static func hashtagTableView() -> UITableView {
            let tableView = UITableView(frame: .zero, style: .grouped)
            tableView.register(cellType: TagManagementTableViewCell.self)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }
        
    }
    
}
