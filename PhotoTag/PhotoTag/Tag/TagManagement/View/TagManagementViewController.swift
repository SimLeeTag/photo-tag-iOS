//
//  TagManagementViewController.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/10/27.
//

import UIKit

class TagManagementViewController: UIViewController {
    
    // MARK: - Properties
    weak var coordinator: TagCoordinator?
    private var tagManagementView: TagManagementView! {
        return view as? TagManagementView
    }
    
    // MARK: - Intialization
    //TODO:- add viewModel as parameter
    init(coordinator: TagCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: - Life Cycle
    override func loadView() {
        view = TagManagementView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure () {
        self.navigationController?.isNavigationBarHidden = true
        tagManagementView.backButton.addTarget(self, action: #selector(navigateToTagCategory), for: .touchUpInside)
    }
    
    // MARK: - Functions
    @objc func navigateToTagCategory() {
        self.navigationController?.popViewController(animated: true)
    }
}
