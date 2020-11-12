//
//  TagManagementTableViewDelegate.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/11.
//

import UIKit

protocol ViewControllerDelegate: class {
    func makeArchivingSwipeMenu(_ tableView: UITableView, indexPath: IndexPath) -> UIContextualAction
    func makeActivatingSwipeMenu(_ tableView: UITableView, indexPath: IndexPath) -> UIContextualAction
}

class TagManagementTableViewDelegate: NSObject, UITableViewDelegate {

    weak var delegate: ViewControllerDelegate?
    
    init(withDelegate delegate: ViewControllerDelegate) {
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let archivingSwipeMenu =  self.delegate?.makeArchivingSwipeMenu(tableView, indexPath: indexPath) else { return UISwipeActionsConfiguration()}
        
        guard let activatingSwipeMenu = self.delegate?.makeActivatingSwipeMenu(tableView, indexPath: indexPath) else { return UISwipeActionsConfiguration() }
        
        if indexPath.section == TagManagementTableViewConstant.activeHashtagsSectionNumber {
            return UISwipeActionsConfiguration(actions: [
                archivingSwipeMenu
            ])
        }
        
        return UISwipeActionsConfiguration(actions: [
            activatingSwipeMenu
        ])
    }
    
}
