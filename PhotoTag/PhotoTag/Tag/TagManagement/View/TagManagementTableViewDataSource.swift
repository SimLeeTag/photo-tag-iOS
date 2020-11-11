//
//  TagManagementTableViewDataSource.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/11.
//

import UIKit

class TagManagementTableViewDataSource: NSObject, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        TagManagementTableViewConstant.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionTitle = ""
        if section == TagManagementTableViewConstant.activeHashtagsSectionNumber {
            sectionTitle = TagManagementTableViewConstant.activeHashtagsSectionHeaderTitle
        } else {
            sectionTitle = TagManagementTableViewConstant.archivedHashtagsSectionHeaderTitle
        }
        return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5 // 추후 변경 예정입니다.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: TagManagementTableViewCell.self, for: indexPath)
        return cell
    }
    
}
