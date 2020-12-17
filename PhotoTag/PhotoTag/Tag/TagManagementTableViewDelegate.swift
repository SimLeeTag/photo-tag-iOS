//
//  TagManagementTableViewDelegate.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/11.
//

import UIKit

final class TagManagementTableViewDelegate: NSObject, UITableViewDelegate {
    
    var viewModel: TagManagementViewModel?

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let cell = tableView.cellForRow(at: indexPath) as? TagManagementTableViewCell, let cellTagId = cell.tagId else {return UISwipeActionsConfiguration()}
        
        func didRestore() {
            viewModel?.updateHashtagState(tagId: cellTagId, willBe: .activated)
            sendNotification()
        }
        
        func didArchive() {
            viewModel?.updateHashtagState(tagId: cellTagId, willBe: .archived)
            sendNotification()
        }
        
        let restore = ActionType.make(.restore, handler: didRestore)
        let archive = ActionType.make(.archive, handler: didArchive)
        
        if indexPath.section == TagManagementConstant.activeHashtagsSectionNumber {
            return UISwipeActionsConfiguration(actions: [archive])
        }
        
        return UISwipeActionsConfiguration(actions: [restore])
    }
    
    private func sendNotification() {
        NotificationCenter.default.post(name: .tagManagementViewModelUpdated, object: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TagManagementConstant.cellHeight
    }
    
}

// MARK: - SwipeAction
extension TagManagementTableViewDelegate {
    func updateViewModel(with newViewModel: TagManagementViewModel) {
        self.viewModel = newViewModel
    }
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
}
