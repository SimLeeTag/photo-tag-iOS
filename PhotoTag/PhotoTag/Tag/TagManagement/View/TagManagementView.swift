//
//  TagManagementView.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/06.
//

import UIKit

class TagManagementView: ScrollableContentViewWithHead {
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
        contentStackView.addArrangedSubview(headerStackView)
        contentStackView.addArrangedSubview(hashtagTableView)
        configureContentView()
    }
    
    override func configureHeaderView() {
        headerStackView.addArrangedSubview(backButton)
        headerStackView.addArrangedSubview(titleLabel)
    }
    
    override func setupLayout() {
        titleLabel.pinWidth(to: self.widthAnchor, multiplier: 0.95)
        headerStackView.pinHeight(to: self.heightAnchor, multiplier: 0.1)
        contentView.pinEdges(to: scrollView)
        scrollView.pinEdges(to: self, edgeInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
}

private extension TagManagementView {
    
    struct SubviewFactory {
        
        static func backButton() -> UIButton {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: "ios-arrow-back"), for: .normal)
            return button
        }
        
        static func titleLabel() -> UILabel {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Manage Hashtags"
            label.font = UIFont.boldSystemFont(ofSize: 20.0)
            label.textAlignment = .left
            return label
        }
        
        static func hashtagTableView() -> UITableView {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }
        
    }
    
}
