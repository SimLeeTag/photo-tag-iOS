//
//  TagCategoryViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/24.
//

import UIKit

class TagCategoryViewController: UIViewController {
    
    weak var delegate: TagCoordinator?
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //TODO:- add button to present tag management ViewController
    
    let goToPhotoListButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.setTitle("navigateToPhotoNoteList", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(navigateToPhotoNoteList), for: .touchUpInside)
        return button
    }()
    
    //TODO:- add viewModel as parameter
    init(delegate: TagCoordinator) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        contentView.addSubview(goToPhotoListButton)
        view.addSubview(contentView)
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        goToPhotoListButton.topAnchor.constraint(greaterThanOrEqualTo: self.view.centerYAnchor, constant: 100).isActive = true
        goToPhotoListButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        goToPhotoListButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        goToPhotoListButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        title = "\(String(describing: self))"

        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(navigateToTagManagement))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func navigateToTagManagement() {
//        self.delegate?.navigateToTagManagement()
    }
    
    @objc func navigateToPhotoNoteList() {
//        self.delegate?.navigateToPhotoNoteList()
    }
}
