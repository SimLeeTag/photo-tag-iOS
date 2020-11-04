//
//  LoginView.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/27.
//

import UIKit
import AuthenticationServices

class LoginView: UIView {
    
    let logoImageView = SubviewFactory.logoImageView()
    let contentStackView = SubviewFactory.contentStackView()
    let buttonStackView = SubviewFactory.buttonStackView()
    let appleLoginButton = SubviewFactory.appleLoginButton()
    let howToUseButton = SubviewFactory.howToUseButton()
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) { return nil }
    
    private func addSubviews() {
        buttonStackView.addArrangedSubview(appleLoginButton)
        buttonStackView.addArrangedSubview(howToUseButton)
        contentStackView.addArrangedSubview(logoImageView)
        contentStackView.addArrangedSubview(buttonStackView)
        contentView.addSubview(contentStackView)
        self.addSubview(contentView)
        
    }
    
    private func setupLayout() {
        contentStackView.pinCenterX(to: self.centerXAnchor)
        contentStackView.pinCenterY(to: self.centerYAnchor)
        contentStackView.pinWidth(to: self.widthAnchor, multiplier: 0.6)
        contentStackView.aspectRation(1.0/5.0)
        contentView.pinEdges(to: self)
    }
    
}

private extension LoginView {

    struct SubviewFactory {
        
        static func logoImageView() -> UIImageView {
            let imageView = UIImageView(frame: .zero)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.isUserInteractionEnabled = false
            imageView.image = #imageLiteral(resourceName: "logo.png")
            return imageView
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
        
        static func buttonStackView() -> UIStackView {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.alignment = .fill
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.spacing = 10
            return stackView
        }

        static func appleLoginButton() -> ASAuthorizationAppleIDButton {
            let button = ASAuthorizationAppleIDButton()
            return button
        }

        static func howToUseButton() -> UIButton {
            let button = UIButton(frame: .zero)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("How To Use", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
            button.layer.cornerRadius = 5
            return button
        }

    }

}
