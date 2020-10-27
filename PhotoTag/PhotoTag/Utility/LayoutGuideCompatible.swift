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
    
    // MARK: - translatesAutoresizingMaskIntoConstraints
    func prepareForSettingConstraints() {
        guard let view = self as? UIView else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Sides
    
    func pinTop(to yAxis: NSLayoutAnchor<NSLayoutYAxisAnchor>, offset: CGFloat = 0) -> NSLayoutConstraint {
        prepareForSettingConstraints()
        let constraint = topAnchor.constraint(equalTo: yAxis, constant: offset)
        constraint.isActive = true
        return constraint
    }
    
    func pinLeading(to xAxis: NSLayoutAnchor<NSLayoutXAxisAnchor>, offset: CGFloat = 0) -> NSLayoutConstraint {
        prepareForSettingConstraints()
        let constraint = leadingAnchor.constraint(equalTo: xAxis, constant: offset)
        constraint.isActive = true
        return constraint
    }
    
    func pinTrailing(to xAxis: NSLayoutAnchor<NSLayoutXAxisAnchor>, offset: CGFloat = 0) -> NSLayoutConstraint {
        prepareForSettingConstraints()
        let constraint = trailingAnchor.constraint(equalTo: xAxis, constant: offset)
        constraint.isActive = true
        return constraint
    }
    
    func pinBottom(to yAxis: NSLayoutAnchor<NSLayoutYAxisAnchor>, offset: CGFloat = 0) -> NSLayoutConstraint {
        prepareForSettingConstraints()
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
    
    func pinCenterX(to xAxis: NSLayoutXAxisAnchor, offset: CGFloat = 0) -> NSLayoutConstraint {
        prepareForSettingConstraints()
        let contraint = centerXAnchor.constraint(equalTo: xAxis, constant: offset)
        contraint.isActive = true
        return contraint
    }
    
    func pinCenterY(to yAxis: NSLayoutYAxisAnchor,
                    offset: CGFloat = 0) -> NSLayoutConstraint {
        prepareForSettingConstraints()
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
        prepareForSettingConstraints()
        let constraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: multiplier, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func alignCenterY(with view: LayoutGuideCompatible, multiplier: CGFloat = 1, constant: CGFloat = 0) -> NSLayoutConstraint {
        prepareForSettingConstraints()
        let constraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: multiplier, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
}
