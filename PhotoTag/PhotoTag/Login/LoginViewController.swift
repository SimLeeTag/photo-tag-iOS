//
//  LoginViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/20.
//

import UIKit

protocol LoginDelegate: class {
    func navigateToTagCategory()
}

class LoginViewController: UIViewController {
    
    weak var delegate: LoginDelegate?
    
    private let loginContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let btnLogin: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .blue
        btn.setTitle("Login", for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(navigateToTagCategory), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        loginContentView.addSubview(btnLogin)
        view.addSubview(loginContentView)
        loginContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loginContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loginContentView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        loginContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        btnLogin.topAnchor.constraint(greaterThanOrEqualTo: self.view.centerYAnchor, constant: 100).isActive = true
        btnLogin.leadingAnchor.constraint(equalTo: loginContentView.leadingAnchor, constant: 20).isActive = true
        btnLogin.trailingAnchor.constraint(equalTo: loginContentView.trailingAnchor, constant: -20).isActive = true
        btnLogin.heightAnchor.constraint(equalToConstant: 50).isActive = true
        title = "\(String(describing: self))"
    }
    
    @objc func navigateToTagCategory(_ sender: Any) {
        self.delegate?.navigateToTagCategory()
    }
    
}
