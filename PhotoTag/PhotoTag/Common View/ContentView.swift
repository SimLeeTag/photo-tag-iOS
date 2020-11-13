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
    @UsesAutoLayout var contentView = SubviewFactory.contentView()
    @UsesAutoLayout var contentStackView = SubviewFactory.contentStackView()
    
    func addSubviews() { }
    func setupLayout() { }
    func configureContentView() { }
}

private extension ContentView {
    
    struct SubviewFactory {
        
        static func contentView() -> UIView {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }
        
        static func contentStackView() -> UIStackView {
            let stackView = UIStackView()
            stackView.alignment = .fill
            stackView.axis = .vertical
            stackView.distribution = .fill
            return stackView
        }
    }
}
