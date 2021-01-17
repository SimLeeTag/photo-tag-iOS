//
//  LoginViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/20.
//

import UIKit
import AuthenticationServices

enum UserDefaultKey {
    static let key = "userId"
    static let selectedTagIds = "selectedTagIds"
}

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private weak var coordinator: AppCoordinator?
    private let loginManager = LoginManager()
    private var loginView: LoginView! {
        return view as? LoginView
    }
    
    // MARK: - Intialization
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = LoginView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Functions
    
    private func configure () {
        self.navigationController?.isNavigationBarHidden = true
        loginView.appleLoginButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        // TODO: - navigate to tutorial scene
        loginView.howToUseButton.addTarget(self, action: #selector(navigateToTagCategory(_:)), for: .touchUpInside)
    }
    
    @objc func navigateToTagCategory(_ sender: Any) {
        coordinator?.navigateToSelectTagCategory()
    }
    
    @objc private func handleAuthorizationAppleIDButtonPress() {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        } else {
            self.present( UIAlertController(title: "Alert", message: "To Start Service, you need to update iOS 13", preferredStyle: .alert), animated: true)
        }
    }
    
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        
        loginManager.requestAppleLoginToken(credential: appleIDCredential)
        coordinator?.navigateToSelectTagCategory()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func showPasswordCredentialAlert(username: String, password: String) {
        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        let alertController = UIAlertController(title: "Keychain Credential Received",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // TODO: - Handle error.
        debugPrint(error)
    }
    
}
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
