//
//  AddSubtaskVC.swift
//  organizer
//
//  Created by Tevin Scott on 1/12/17.
//  Copyright © 2017 Tevin Scott. All rights reserved.
//

import Foundation
import UIKit

class SubtaskTV: UITableView, UITableViewDataSource, UITableViewDelegate {
    var parentTask: TaskCoreData?
    var subtaskList = [SubTaskCoreData]();
    var hasSubtasks: Bool = false;
    let DATAMANGER = DataManager.init()
    //intializer
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isScrollEnabled = false
        self.dataSource = self
        self.delegate = self
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : SubtaskTVCell
        cell = self.dequeueReusableCell(withIdentifier: "subtaskCell", for: indexPath) as! SubtaskTVCell
        cell.subtaskField.text = subtaskList[indexPath.row].subTitle
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            if(subtaskList.count == 0){
                parentTask?.hasSubtasks = false;
                hasSubtasks = false
            }
            DATAMANGER.deleteSubTask(subtask: subtaskList[indexPath.row])
            subtaskList = DATAMANGER.getSubTasks(parentTask: parentTask!)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
            
        }
    }
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subtaskList.count
    }
    /*
     *controls the set of buttons in the subtask table
     *adds the new subtask if the subtask has not been added
     *otherwise removes the 
     */
    func checkButtonClicked(sender:UIButton) {
        //let buttonRow = sender.tag
        //let cellhandle : SubtaskTVCell =
          //  self.cellForRow(at: IndexPath(row: buttonRow, section: 0)) as! SubtaskTVCell
    }
}
