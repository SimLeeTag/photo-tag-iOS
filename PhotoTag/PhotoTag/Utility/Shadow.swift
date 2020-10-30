//
//  Shadow.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/28.
//

import UIKit

struct Shadow {
    let color: UIColor?
    let x: CGFloat
    let y: CGFloat
    let blur: CGFloat
    let spread: CGFloat
}

extension CALayer {
    func makeShadow(with shadow: Shadow) {
        shadowColor = shadow.color?.cgColor
        shadowOpacity = 0.4
        shadowOffset = CGSize(width: shadow.x, height: shadow.y)
        shadowRadius = shadow.blur / 3.0
        if shadow.spread == 0 {
            shadowPath = nil
        } else {
            let dx = -shadow.spread // 직사각형을 더 크게 만들려면 음수로 지정
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
