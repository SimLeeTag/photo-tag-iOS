//
//  PhotoNoteListViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/26.
//

import UIKit

class PhotoNoteListViewController: UIViewController {
    
    weak var coordinator: PhotoNoteCoordinator? // show tag category create new note
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //TODO: - add right tap gestrue to navigate to tag category
    
    //TODO: - add left tap gestrue to navigate to select photo
    
    let tagCategoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.setTitle("go to tagCategory", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(navigateToTagCategory), for: .touchUpInside)
        return button
    }()
    
    let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.setTitle("select Photo Button", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(navigateToSelectPhoto), for: .touchUpInside)
        return button
    }()
    
    //TODO:- add viewModel as parameter
    init(coordinator: PhotoNoteCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        contentView.addSubview(tagCategoryButton)
        view.addSubview(contentView)
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tagCategoryButton.topAnchor.constraint(greaterThanOrEqualTo: self.view.centerYAnchor, constant: 100).isActive = true
        tagCategoryButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        tagCategoryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        tagCategoryButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        title = "\(String(describing: self))"
        
        contentView.addSubview(selectPhotoButton)
        selectPhotoButton.bottomAnchor.constraint(greaterThanOrEqualTo: self.view.centerYAnchor, constant: 200).isActive = true
        selectPhotoButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        selectPhotoButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        selectPhotoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func navigateToTagCategory() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func navigateToSelectPhoto() {
        coordinator?.navigateToSelectPhoto()
    }
}
