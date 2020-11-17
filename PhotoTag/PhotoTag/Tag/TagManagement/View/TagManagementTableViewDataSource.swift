//
//  TagManagementTableViewDataSource.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/11.
//

import UIKit

class TagManagementTableViewDataSource: NSObject, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        TagManagementConstant.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return section == TagManagementConstant.activeHashtagsSectionNumber ? TagManagementConstant.activeHashtagsSectionHeaderTitle : TagManagementConstant.archivedHashtagsSectionHeaderTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5 // 추후 변경 예정입니다.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(with: TagManagementTableViewCell.self, for: indexPath)
        tableViewCell.selectionStyle = .none
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
}
