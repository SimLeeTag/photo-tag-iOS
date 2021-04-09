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

final class PhotoNoteListView: ContentViewWithHeader {
    
    // MARK: - Properties
    @UsesAutoLayout private(set) var searchButton = SubviewFactory.searchButton()
    @UsesAutoLayout private(set) var selectedTagsStackView = SubviewFactory.selectedTagsStackView()
    @UsesAutoLayout var photoNoteListTableView = SubviewFactory.photoNoteListTableView()
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
        headerStackView.addArrangedSubview(selectedTagsStackView)
        headerStackView.addArrangedSubview(searchButton)
    }
    
    override func configureContentView() {
        contentView.addSubview(headerStackView)
        contentView.addSubview(photoNoteListTableView)
    }
    
    override func setupLayout() {
        headerStackView.pinHeight(to: self.heightAnchor, multiplier: 0.03)
        contentView.pinEdges(to: self)
        headerStackView.alignment = .fill
        headerStackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        headerStackView.pinTop(to: self.safeAreaLayoutGuide.topAnchor, offset: .twenty)
        headerStackView.pinLeading(to: contentView.leadingAnchor, offset: .ten)
        headerStackView.pinTrailing(to: contentView.trailingAnchor, offset: .ten)
        selectedTagsStackView.pinWidth(to: contentView.widthAnchor, multiplier: .zeroPointEight)
        photoNoteListTableView.pinTop(to: headerStackView.bottomAnchor, offset: 10)
        photoNoteListTableView.pinLeading(to: contentView.leadingAnchor, offset: 16)
        photoNoteListTableView.pinTrailing(to: contentView.trailingAnchor, offset: -16)
        photoNoteListTableView.pinBottom(to: contentView.bottomAnchor, offset: -10)
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
        
        static func photoNoteListTableView() -> UITableView {
            let tableView = UITableView()
            tableView.register(cellType: PhotoNoteListTableViewCell.self)
            tableView.backgroundColor = .clear
            tableView.allowsMultipleSelection = false
            tableView.showsVerticalScrollIndicator = false
            tableView.showsHorizontalScrollIndicator = false
            return tableView
        }
    }
}
