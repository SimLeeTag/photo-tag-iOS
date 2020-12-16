//
//  TagManagementTableViewDataSource.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/11.
//

import UIKit

final class TagManagementTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var viewModel = TagManagementViewModel()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        TagManagementConstant.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return section == TagManagementConstant.activeHashtagsSectionNumber ? TagManagementConstant.activeHashtagsSectionHeaderTitle : TagManagementConstant.archivedHashtagsSectionHeaderTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let isActivatedSection = section == 0
        return isActivatedSection ? viewModel.updatedHashtagCount(of: .activated) : viewModel.updatedHashtagCount(of: .archived)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(with: TagManagementTableViewCell.self, for: indexPath)
        tableViewCell.selectionStyle = .none
        let isActivatedSection = indexPath.section == 0
        bind(with: tableViewCell)
        
        if isActivatedSection, viewModel.updatedHashtagCount(of: .activated) != 0 {
            tableViewCell.fill(with: self.viewModel.activatedHashtags.value[indexPath.row])
            return tableViewCell
        }
        if viewModel.updatedHashtagCount(of: .archived) != 0 {
            tableViewCell.fill(with: self.viewModel.archivedHashtags.value[indexPath.row])
        }
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

}

extension TagManagementTableViewDataSource {
    func updateViewModel(updatedViewModel: TagManagementViewModel) {
        self.viewModel = updatedViewModel
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
