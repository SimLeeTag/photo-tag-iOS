//
//  TagManagementView.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/06.
//

import UIKit

class TagManagementView: ContentViewWithHeader {
    
    // MARK: - Properties
    @UsesAutoLayout var backButton = SubviewFactory.backButton()
    @UsesAutoLayout var titleLabel = SubviewFactory.titleLabel()
    @UsesAutoLayout var hashtagTableView = SubviewFactory.hashtagTableView()
    
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
            button.setImage(.back, for: .normal)
            button.tintColor = .black
            button.contentHorizontalAlignment = .center
            return button
        }
        
        static func titleLabel() -> UILabel {
            let label = UILabel()
            label.text = TagManagementConstant.title
            label.font = UIFont.boldSystemFont(ofSize: .twenty)
            label.textAlignment = .left
            return label
        }
        
        static func hashtagTableView() -> UITableView {
            let tableView = UITableView(frame: .zero, style: .grouped)
            tableView.register(cellType: TagManagementTableViewCell.self)
            return tableView
        }
        
    }
    
}
