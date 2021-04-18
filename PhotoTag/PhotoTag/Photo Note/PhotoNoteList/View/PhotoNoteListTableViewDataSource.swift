//
//  PhotoNoteListTableViewDataSource.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2021/01/21.
//

import UIKit

final class PhotoNoteListTableViewDataSource: NSObject, UITableViewDataSource {
    
    var noteList = [PhotoNote]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // fill data except image first
        let tableViewCell = tableView.dequeueReusableCell(with: PhotoNoteListTableViewCell.self, for: indexPath)
        
        /* for now, deliver only the "PhotoNote" structure needed for the cell.
         Additional actions for the cell are executed on other code later. (TableViewDelegate)
         */
        tableViewCell.photoNote = noteList[indexPath.row]
        
        // no effect when cell is selected
        DispatchQueue.main.async { tableViewCell.selectionStyle = .none }
        
        return tableViewCell
    }    
}
