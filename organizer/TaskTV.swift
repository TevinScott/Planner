//
//  AddSubtaskVC.swift
//  organizer
//
//  Created by Tevin Scott on 1/12/17.
//  Copyright © 2017 Tevin Scott. All rights reserved.
//

import Foundation
import UIKit
class TaskTV: UITableView, UITableViewDataSource, UITableViewDelegate {
    var taskList : [Task] = [Task]()
    var selectedCellIndexPath: NSIndexPath?
    let selectedCellHeight: CGFloat = 291.0
    let unselectedCellHeight: CGFloat = 67.0
    var cellHeight : CGFloat = 67.0
    //intializer
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dataSource = self
        self.delegate = self
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : TaskTVCell
        cell = self.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTVCell
        cell.isUserInteractionEnabled = true
        cell.taskObj = taskList[indexPath.row]
        if(taskList[indexPath.row].hasSubtask){
            cell.subtaskTableView.subtaskList = taskList[indexPath.row].subtasks!
        }
        cell.setCellElements()
        if(cell.hasSubtasks){
            cell.viewSubtask.tag = indexPath.row
            cell.viewSubtask.addTarget(self, action: #selector(self.viewSubtaskButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedCellIndexPath != nil && selectedCellIndexPath == indexPath as NSIndexPath {
            selectedCellIndexPath = nil
        } else {
            selectedCellIndexPath = indexPath as NSIndexPath?
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        if selectedCellIndexPath != nil {
            // This ensures, that the cell is fully visible once expanded
            tableView.scrollToRow(at: indexPath as IndexPath, at: .none, animated: true)
        }
    }
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    func evalTaskContents(_ task: Task){
        
    }
    /*
     *controls the set of buttons in the subtask table
     *adds the new subtask if the subtask has not been added
     *otherwise removes the 
     */
    func viewSubtaskButtonClicked(sender:UIButton) {
        let buttonRow = sender.tag
        let cellhandle : TaskTVCell =
        self.cellForRow(at: IndexPath(row: buttonRow, section: 0)) as! TaskTVCell
        if(!cellhandle.isExpanded && cellhandle.hasSubtasks){
            cellHeight = selectedCellHeight
            cellhandle.isExpanded = true
        }
        else if (cellhandle.isExpanded && cellhandle.hasSubtasks){
            cellHeight = unselectedCellHeight
            cellhandle.isExpanded = false
        }
        cellhandle.frame.size.height = cellHeight
        //self.reloadRows(at: [IndexPath(row: buttonRow, section: 0)], with: UITableViewRowAnimation.fade)
    }
}

