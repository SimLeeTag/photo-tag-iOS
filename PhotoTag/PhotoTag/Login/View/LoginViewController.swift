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
    private let loginManager = LoginManager()
    private var loginView: LoginView! {
        return view as? LoginView
    }
    
    // MARK: - Intialization
    init(delegate: CoordinatorDelegate) {
        self.delegate = delegate
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performExistingAccountSetupFlows()
    }
    
    // MARK: - Functions
    
    private func configure () {
        self.navigationController?.isNavigationBarHidden = true
        loginView.appleLoginButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        loginView.googleLoginButton.addTarget(self, action: #selector(navigateToTagCategory(_:)), for: .touchUpInside)
    }
    
    @objc func navigateToTagCategory(_ sender: Any) {
        self.delegate?.navigateToTagCategory()
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
    
    private func performExistingAccountSetupFlows() {
        let appleIDProviderRequest = ASAuthorizationAppleIDProvider().createRequest()
        let passwordProviderRequest = ASAuthorizationAppleIDProvider().createRequest()
        appleIDProviderRequest.requestedScopes = [.fullName, .email]
        passwordProviderRequest.requestedScopes = [.fullName, .email]
        let requests = [appleIDProviderRequest,
                        passwordProviderRequest]
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        guard let token = appleIDCredential.identityToken else { return }
        guard let jwt = String(data: token, encoding: .utf8) else { return }
        loginManager.saveUserInKeychain(jwt)
        loginManager.requestAppleLoginToken(credential: appleIDCredential)
        self.delegate?.navigateToTagCategory()
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
    }
    
}
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
