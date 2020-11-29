//
//  TagManagementTableViewDataSource.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/11.
//

import UIKit

class TagManagementTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var viewModel = TagManagementViewModel()

    func updateViewModel(updatedViewModel: TagManagementViewModel) {
        self.viewModel = updatedViewModel
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        TagManagementConstant.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return section == TagManagementConstant.activeHashtagsSectionNumber ? TagManagementConstant.activeHashtagsSectionHeaderTitle : TagManagementConstant.archivedHashtagsSectionHeaderTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let isActivatedSection = section == 0
        return isActivatedSection ? viewModel.activatedHashtagCounts : viewModel.archivedHashtagCounts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 뷰모델에서 가지고 온
        let tableViewCell = tableView.dequeueReusableCell(with: TagManagementTableViewCell.self, for: indexPath)
        tableViewCell.selectionStyle = .none
        let isActivatedSection = indexPath.section == 0
        bind(with: tableViewCell)
        if isActivatedSection {
            tableViewCell.fill(with: viewModel.activatedHashtags.value[indexPath.row])
            return tableViewCell
        }
        tableViewCell.fill(with: viewModel.archivedHashtags.value[indexPath.row])
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    private func bind(with cell: TagManagementTableViewCell) {
        let cellViewModel = TagManagementCellViewModel()
        cellViewModel.noteCount.bind { noteCount in
            cell.noteCountLabel.text = "\(noteCount)"
        }
        cellViewModel.tagName.bind { tagName in
            cell.tagNameLabel.text = tagName
        }
    }
    
}
