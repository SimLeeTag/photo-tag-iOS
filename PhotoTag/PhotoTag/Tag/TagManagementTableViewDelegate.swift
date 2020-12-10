//
//  TagManagementTableViewDelegate.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/11.
//

import UIKit

class TagManagementTableViewDelegate: NSObject, UITableViewDelegate {
    
    var viewModel: TagManagementViewModel?

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let cell = tableView.cellForRow(at: indexPath) as? TagManagementTableViewCell, let cellTagId = cell.tagId else {return UISwipeActionsConfiguration()}
        
        func didRestore() {
            viewModel?.restoreHashtag(with: cellTagId)
            viewModel?.updateHashtagState(tagId: cellTagId, willBe: .activated)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.insertRows(at: [IndexPath(row: indexPath.last!, section: TagManagementConstant.activeHashtagsSectionNumber)], with: .automatic)
        }
        
        func didArchive() {
            viewModel?.archiveHashtag(with: cellTagId)
            viewModel?.updateHashtagState(tagId: cellTagId, willBe: .archived)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.insertRows(at: [IndexPath(row: indexPath.last!, section: TagManagementConstant.activeHashtagsSectionNumber)], with: .automatic)
        }
        
        let restore = ActionType.make(.restore, handler: didRestore)
        let archive = ActionType.make(.archive, handler: didArchive)
        
        if indexPath.section == TagManagementConstant.activeHashtagsSectionNumber {
            return UISwipeActionsConfiguration(actions: [archive])
        }
        
        return UISwipeActionsConfiguration(actions: [restore])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TagManagementConstant.cellHeight
    }
    
}

// MARK: - SwipeAction
extension TagManagementTableViewDelegate {
    enum ActionType {
        case restore
        case archive
        
        struct Attribute {
            let style: UIContextualAction.Style
            let title: String?
        }
        
        static func make(_ actionType: ActionType, handler: @escaping () -> Void) -> UIContextualAction {
            let type = actionType.attribute
            let action = UIContextualAction(style: type.style, title: type.title) { action, view, completion in
                handler()
                completion(true)
            }
            
            return action
        }
        
        var attribute: Attribute {
            switch self {
            case .restore:
                return Attribute(style: .normal, title: "Restore")
            case .archive:
                return Attribute(style: .destructive, title: "Archive")
            }
        }
    }
    
    // TODO: - need to check whether use or not
    private func makeArchiveContextualAction(_ tableView: UITableView, forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: TagManagementConstant.activeHashtagSwipeMenuText) { (_, _, completion) in
            tableView.beginUpdates()
            // viewModel update
            // 여기서 네트워크에 연결
            guard let cell = tableView.cellForRow(at: indexPath) as? TagManagementTableViewCell, let cellTagId = cell.tagId else {return}
            self.viewModel?.updateHashtagState(tagId: cellTagId, willBe: .archived)
            tableView.reloadData()
            tableView.moveSection(indexPath.section, toSection: 1)
            completion(true)
            tableView.endUpdates()
            
        }
    }
    
    private func makeRestoreContextualAction(_ tableView: UITableView, forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: TagManagementConstant.archivedHashtagSwipeMenuText) { (_, _, completion) in
            tableView.beginUpdates()
            guard let cell = tableView.cellForRow(at: indexPath) as? TagManagementTableViewCell, let cellTagId = cell.tagId else {return}
            self.viewModel?.updateHashtagState(tagId: cellTagId, willBe: .activated)
            tableView.moveSection(indexPath.section, toSection: 0)
            tableView.reloadData()
            completion(true)
            tableView.endUpdates()
        }
    }
}
