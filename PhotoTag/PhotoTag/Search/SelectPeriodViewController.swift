//
//  SelectPeriodViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/06.
//

import UIKit

final class SelectPeriodViewController: UIViewController {

    weak var coordinator: SearchCoordinator?
    
    //TODO:- add viewModel as parameter
    init(coordinator: SearchCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
