//
//  TagManagementTableViewDelegate.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/11.
//

import UIKit

class TagManagementTableViewDelegate: NSObject, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        if indexPath.section == TagManagementConstant.activeHashtagsSectionNumber {
            return UISwipeActionsConfiguration(actions: [
                makeArchiveContextualAction(tableView, forRowAt: indexPath)
            ])
        }
        
        return UISwipeActionsConfiguration(actions: [
            makeRestoreContextualAction(tableView, forRowAt: indexPath)
        ])
    }
    
    private func makeArchiveContextualAction(_ tableView: UITableView, forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Archive") { (_, _, completion) in
            tableView.moveSection(indexPath.section, toSection: TagManagementConstant.archivedHashtagsSectionNumber)
            completion(true)
        }
    }
    
    private func makeRestoreContextualAction(_ tableView: UITableView, forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: "Restore") { (_, _, completion) in
            
            tableView.moveSection(indexPath.section, toSection: TagManagementConstant.activeHashtagsSectionNumber)
            completion(true)
        }
    }
    
}
