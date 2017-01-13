//
//  AddSubtaskVC.swift
//  organizer
//
//  Created by Tevin Scott on 1/12/17.
//  Copyright © 2017 Tevin Scott. All rights reserved.
//

import Foundation
import UIKit
class MainTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    var taskList : [Task] = [Task]()
    //intializer
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dataSource = self
        self.delegate = self
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : TaskTVCell
        cell = self.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTVCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.taskTitle.text = taskList[indexPath.row].title
        //cell.titleOnly()
        //cell.addSTButton.tag = indexPath.row
        //cell.addSTButton.addTarget(self, action: #selector(self.checkButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        return cell
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
        
        
    }
    /*
     *controls the set of buttons in the subtask table
     *adds the new subtask if the subtask has not been added
     *otherwise removes the 
     */
    func checkButtonClicked(sender:UIButton) {
        //let buttonRow = sender.tag
        //let cellhandle : CustomTableViewCell =
            //self.cellForRow(at: IndexPath(row: buttonRow, section: 0)) as! CustomTableViewCell
       
    }
}

