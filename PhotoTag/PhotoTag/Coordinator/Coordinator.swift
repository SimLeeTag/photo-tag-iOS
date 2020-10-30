//
//  Coordinator.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/23.
//

import UIKit

protocol Coordinator: class {
    
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    init(navigationController: UINavigationController)
    
    func start()
}
