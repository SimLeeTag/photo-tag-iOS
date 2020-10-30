//
//  LoginViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/20.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private weak var delegate: CoordinatorDelegate?

    // MARK: - Initializer and Life Cycle
    // TODO:- add viewModel as parameter
    init(delegate: CoordinatorDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func loadView() {
        view = LoginView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        guard let loginView = self.view as? LoginView else { return }
        loginView.appleLoginButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        loginView.googleLoginButton.addTarget(self, action: #selector(navigateToTagCategory(_:)), for: .touchUpInside)
    }
    
    @objc func navigateToTagCategory(_ sender: Any) {
        self.delegate?.navigateToTagCategory()
    }
    
    @objc func handleAuthorizationAppleIDButtonPress() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}
extension LoginViewController: ASAuthorizationControllerDelegate {
    
}
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
}
