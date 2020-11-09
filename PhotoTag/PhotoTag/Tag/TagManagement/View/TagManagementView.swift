//
//  TagManagementView.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/06.
//

import UIKit

class TagManagementView: UIView {
    let contentView = SubviewFactory.contentView()
    let scrollView = SubviewFactory.sceneScrollView()
    let headerStackView = SubviewFactory.headerStackView()
    let backButton = SubviewFactory.backButton()
    let contentStackView = SubviewFactory.contentStackView()
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
    private func addSubviews() {
        headerStackView.addArrangedSubview(backButton)
        headerStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(headerStackView)
        contentStackView.addArrangedSubview(hashtagTableView)
        contentView.addSubview(contentStackView)
        self.addSubview(contentView)
        scrollView.addSubview(contentView)
    }
    
    private func setupLayout() {
        titleLabel.pinWidth(to: self.widthAnchor, multiplier: 0.95)
        headerStackView.pinHeight(to: self.heightAnchor, multiplier: 0.1)
        contentView.pinEdges(to: scrollView)
        scrollView.pinEdges(to: self, edgeInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
}

private extension TagManagementView {
    
    struct SubviewFactory {
        
        static func contentView() -> UIView {
            let view = UIView()
            view.backgroundColor = .white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }
        
        static func sceneScrollView() -> UIScrollView {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }
        
        static func contentStackView() -> UIStackView {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.alignment = .fill
            stackView.axis = .vertical
            stackView.distribution = .equalSpacing
            stackView.spacing = 50
            return stackView
        }
        
        static func headerStackView() -> UIStackView {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.alignment = .fill
            stackView.axis = .horizontal
            stackView.distribution = .fillProportionally
            return stackView
        }
        
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
