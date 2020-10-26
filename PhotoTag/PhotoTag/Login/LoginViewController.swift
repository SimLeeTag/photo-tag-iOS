//
//  LoginViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/20.
//

import UIKit

class LoginViewController: UIViewController {
    
    weak var delegate: TagSceneTransitioning?
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.setTitle("Sign in with Apple", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(navigateToTagCategory), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        contentView.addSubview(loginButton)
        view.addSubview(contentView)
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        loginButton.topAnchor.constraint(greaterThanOrEqualTo: self.view.centerYAnchor, constant: 100).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        title = "\(String(describing: self))"
    }
    
    @objc func navigateToTagCategory(_ sender: Any) {
        self.delegate?.navigateToTagCategory()
    }
}
