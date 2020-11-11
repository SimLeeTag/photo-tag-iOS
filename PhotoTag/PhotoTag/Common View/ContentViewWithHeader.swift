//
//  ContentViewWithHead.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/11.
//

import UIKit

protocol HeaderRepresentable: Representable {
    var headerStackView: UIStackView { get set }
    var spaceView: UIView { get set }
    
    func configureHeaderView()
}

class ContentViewWithHeader: ContentView, HeaderRepresentable {
    
    var headerStackView = SubviewFactory.headerStackView()
    var spaceView = SubviewFactory.spaceView()
    
    func configureHeaderView() { }
    
    override func configureContentView() {
        contentView.addSubview(contentStackView)
    }
}

private extension ContentViewWithHeader {
    struct SubviewFactory {
        
        static func headerStackView() -> UIStackView {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.alignment = .fill
            stackView.axis = .horizontal
            stackView.distribution = .fill
            return stackView
        }
        
        static func spaceView() -> UIView {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .clear
            return view
        }
    }
}
