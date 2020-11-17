//
//  UITableView.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/11.
//

import UIKit

extension UITableView {
    public func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }

    public func register<T: UITableViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }

    public func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        // swiftlint:disable force_cast
        return dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
}
