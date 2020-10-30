//
//  TagManagementViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/27.
//

import UIKit

class TagManagementViewController: UIViewController {
    
    weak var delegate: CoordinatorDelegate?
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let goToTagCategory: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.setTitle("navigate To Tag Category", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(navigateToTagCategory), for: .touchUpInside)
        return button
    }()
    
    //TODO:- add viewModel as parameter
    init(delegate: CoordinatorDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        contentView.addSubview(goToTagCategory)
        view.addSubview(contentView)
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        goToTagCategory.topAnchor.constraint(greaterThanOrEqualTo: self.view.centerYAnchor, constant: 100).isActive = true
        goToTagCategory.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        goToTagCategory.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        goToTagCategory.heightAnchor.constraint(equalToConstant: 50).isActive = true
        title = "\(String(describing: self))"
        
        //TODO:- add back button to present tag category ViewController
    }
    
    @objc func navigateToTagCategory() {
        self.delegate?.navigateToTagCategory()
    }
}
