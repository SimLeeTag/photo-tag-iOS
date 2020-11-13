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

class ScrollableContentViewWithHeader: ContentViewWithHeader, Scrollable {
    
    @UsesAutoLayout var scrollView = SubviewFactory.sceneScrollView()
    
    override func configureContentView() {
        contentView.addSubview(contentStackView)
        configureScrollView()
    }
    
    func configureScrollView() {
        scrollView.addSubview(contentView)
    }
    
}

private extension ScrollableContentViewWithHeader {
    struct SubviewFactory {
        
        static func sceneScrollView() -> UIScrollView {
            let scrollView = UIScrollView()
            return scrollView
        }
    }
}
