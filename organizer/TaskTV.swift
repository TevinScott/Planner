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
        if(taskList[indexPath.row].subtasks != nil && taskList[indexPath.row].hasSubtask){
            cell.subtaskTableView.subtaskList = taskList[indexPath.row].subtasks!
        }
        cell.setCellElements()
        if(cell.hasSubtasks){
            cell.viewSubtask.tag = indexPath.row
            cell.viewSubtask.addTarget(self, action: #selector(self.viewSubtaskButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if taskList[indexPath.row].hasSubtask{
            if(taskList[indexPath.row].isExpanded){
                return selectedCellHeight
            }
        }
        return unselectedCellHeight

    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            taskList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    /*
     *controls the set of buttons in the subtask table
     *adds the new subtask if the subtask has not been added
     *otherwise removes the 
     */
    func viewSubtaskButtonClicked(sender:UIButton) {
        print("tapped")
        let buttonRow = sender.tag
        let cellhandle : TaskTVCell =
        self.cellForRow(at: IndexPath(row: buttonRow, section: 0)) as! TaskTVCell

        if(!taskList[buttonRow].isExpanded && cellhandle.hasSubtasks){
            //cellHeight = selectedCellHeight
            taskList[buttonRow].isExpanded = true
        }
        else if (taskList[buttonRow].isExpanded && cellhandle.hasSubtasks){
            //cellHeight = unselectedCellHeight
            taskList[buttonRow].isExpanded = false
        }
        self.beginUpdates()
        self.endUpdates()
        self.scrollToRow(at: IndexPath(row: buttonRow, section: 0), at: .none, animated: true)
        //self.reloadRows(at: [IndexPath(row: buttonRow, section: 0)], with: UITableViewRowAnimation.fade)
    }
}

