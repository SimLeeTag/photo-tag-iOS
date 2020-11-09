//
//  ScrollableContentViewWithHead.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/10.
//

import UIKit

protocol Scrollable: Representable {
    var scrollView: UIScrollView { get set }
    
    func configureScrollView()
}

protocol HeaderRepresentable: Representable {
    var headerStackView: UIStackView { get set }
    var spaceView: UIView { get set }
    
    func configureHeaderView()
}

class ScrollableContentViewWithHead: ContentView, HeaderRepresentable, Scrollable {
    
    var headerStackView = SubviewFactory.headerStackView()
    var scrollView = SubviewFactory.sceneScrollView()
    var spaceView = SubviewFactory.spaceView()
    
    func configureHeaderView() { }
    
    func configureScrollView() {
        self.addSubview(contentView)
        scrollView.addSubview(contentView)
    }
    
    override func configureContentView() {
        contentView.addSubview(contentStackView)
        configureScrollView()
    }
}

private extension ScrollableContentViewWithHead {
    struct SubviewFactory {
        
        static func headerStackView() -> UIStackView {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.alignment = .fill
            stackView.axis = .horizontal
            stackView.distribution = .fillProportionally
            return stackView
        }
        
        static func spaceView() -> UIView {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .clear
            return view
        }
        
        static func sceneScrollView() -> UIScrollView {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }
    }
}
