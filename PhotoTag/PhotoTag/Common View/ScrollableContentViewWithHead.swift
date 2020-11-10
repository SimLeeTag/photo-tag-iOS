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

class ScrollableContentViewWithHead: ContentViewWithHead, Scrollable {
    
    var scrollView = SubviewFactory.sceneScrollView()
    
    override func configureContentView() {
        contentView.addSubview(contentStackView)
        configureScrollView()
    }
    
    func configureScrollView() {
        scrollView.addSubview(contentView)
    }
    
}

private extension ScrollableContentViewWithHead {
    struct SubviewFactory {
        
        static func sceneScrollView() -> UIScrollView {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }
    }
}
