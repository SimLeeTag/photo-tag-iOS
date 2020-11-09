//
//  ContentView.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/10.
//

import UIKit

protocol Representable {
    var contentView: UIView { get set }
    var contentStackView: UIStackView { get set }
    
    func addSubviews()
    func setupLayout()
    func configureContentView()
}

class ContentView: UIView, Representable {
    var contentView = SubviewFactory.contentView()
    var contentStackView = SubviewFactory.contentStackView()
    
    func addSubviews() { }
    func setupLayout() { }
    func configureContentView() { }
}

private extension ContentView {
    
    struct SubviewFactory {
        
        static func contentView() -> UIView {
            let view = UIView()
            view.backgroundColor = .white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }
        
        static func contentStackView() -> UIStackView {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.alignment = .fill
            stackView.axis = .vertical
            stackView.distribution = .fillProportionally
            stackView.spacing = 50
            return stackView
        }
    }
}
