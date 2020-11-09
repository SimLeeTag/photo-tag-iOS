//
//  TagCategoryView.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/06.
//

import UIKit

class TagCategoryView: UIView {
    
}

private extension TagCategoryView {

    struct SubviewFactory {

        static func moveToTagManagementButton() -> UIButton {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("", for: .normal)
            return button
        }
        
    }

}
