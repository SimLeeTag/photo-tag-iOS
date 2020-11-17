//
//  LayoutGuideCompatible.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/27.
//

import UIKit

protocol LayoutGuideCompatible {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UILayoutGuide: LayoutGuideCompatible {}
extension UIView: LayoutGuideCompatible {}

extension LayoutGuideCompatible {
    
    // MARK: - Sides
    
    @discardableResult
    func pinTop(to yAxis: NSLayoutAnchor<NSLayoutYAxisAnchor>, offset: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = topAnchor.constraint(equalTo: yAxis, constant: offset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func pinLeading(to xAxis: NSLayoutAnchor<NSLayoutXAxisAnchor>, offset: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = leadingAnchor.constraint(equalTo: xAxis, constant: offset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func pinTrailing(to xAxis: NSLayoutAnchor<NSLayoutXAxisAnchor>, offset: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = trailingAnchor.constraint(equalTo: xAxis, constant: offset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func pinBottom(to yAxis: NSLayoutAnchor<NSLayoutYAxisAnchor>, offset: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = bottomAnchor.constraint(equalTo: yAxis, constant: offset)
        constraint.isActive = true
        return constraint
    }
    
    typealias EdgeLayoutConstraints = (
        top: NSLayoutConstraint,
        leading: NSLayoutConstraint,
        trailing: NSLayoutConstraint,
        bottom: NSLayoutConstraint
    )
    
    @discardableResult
    func pinEdges(to container: LayoutGuideCompatible, edgeInsets: UIEdgeInsets = .zero) -> EdgeLayoutConstraints {
        let edgeLayoutConstraints = EdgeLayoutConstraints(
            top: pinTop(to: container.topAnchor, offset: edgeInsets.top),
            leading: pinLeading(to: container.leadingAnchor, offset: edgeInsets.left),
            trailing: pinTrailing(to: container.trailingAnchor, offset: -edgeInsets.right),
            bottom: pinBottom(to: container.bottomAnchor, offset: -edgeInsets.bottom))
        return edgeLayoutConstraints
    }
    
    // MARK: - Centers
    
    @discardableResult
    func pinCenterX(to xAxis: NSLayoutXAxisAnchor, offset: CGFloat = 0) -> NSLayoutConstraint {
        let contraint = centerXAnchor.constraint(equalTo: xAxis, constant: offset)
        contraint.isActive = true
        return contraint
    }
    
    @discardableResult
    func pinCenterY(to yAxis: NSLayoutYAxisAnchor,
                    offset: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = centerYAnchor.constraint(equalTo: yAxis, constant: offset)
        constraint.isActive = true
        return constraint
    }
    
    typealias CenterLayoutConstraints = (
        centerX: NSLayoutConstraint,
        centerY: NSLayoutConstraint
    )

    @discardableResult
    func pinCenter(to container: LayoutGuideCompatible,
                   offset: CGPoint = .zero) -> CenterLayoutConstraints {
        return CenterLayoutConstraints(
            centerX: pinCenterX(to: container.centerXAnchor),
            centerY: pinCenterY(to: container.centerYAnchor)
        )
    }

    @discardableResult
    func alignCenterX(with view: LayoutGuideCompatible, multiplier: CGFloat = 1, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: multiplier, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func alignCenterY(with view: LayoutGuideCompatible, multiplier: CGFloat = 1, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: multiplier, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    // MARK: - Size
    
    @discardableResult
    func pinHeight(_ height: CGFloat) -> NSLayoutConstraint {
        let constraint = heightAnchor.constraint(equalToConstant: height)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func pinWidth(_ width: CGFloat) -> NSLayoutConstraint {
        let constraint = widthAnchor.constraint(equalToConstant: width)
        constraint.isActive = true
        return constraint
    }
    
    typealias SizeLayoutConstraints = (
        width: NSLayoutConstraint,
        height: NSLayoutConstraint
    )

    @discardableResult
    func pinSize(_ size: CGSize) -> SizeLayoutConstraints {
        return SizeLayoutConstraints(
            width: pinWidth(size.width),
            height: pinHeight(size.height)
        )
    }
    
    @discardableResult
    func pinHeight(to height: NSLayoutDimension, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        let constraint = heightAnchor.constraint(equalTo: height,
                                                 multiplier: multiplier)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func pinWidth(to width: NSLayoutDimension, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        let constraint = widthAnchor.constraint(equalTo: width,
                                                multiplier: multiplier)
        constraint.isActive = true
        return constraint
    }
    
    typealias RelativeSizeLayoutConstraints = (
        top: NSLayoutConstraint,
        leading: NSLayoutConstraint,
        trailing: NSLayoutConstraint,
        bottom: NSLayoutConstraint
    )
    
    @discardableResult
    func pinRelativeSize(to view: LayoutGuideCompatible, widthInset: CGFloat, heightInset: CGFloat) -> RelativeSizeLayoutConstraints {
        return RelativeSizeLayoutConstraints(
            top: pinTop(to: view.topAnchor, offset: heightInset),
            leading: pinLeading(to: view.leadingAnchor, offset: widthInset),
            trailing: pinTrailing(to: view.trailingAnchor, offset: widthInset),
            bottom: pinBottom(to: view.bottomAnchor, offset: heightInset)
        )
    }
    
    @discardableResult
    func aspectRation(_ ratio: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: ratio, constant: 0)
    }
}
