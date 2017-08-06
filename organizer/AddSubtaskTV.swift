//
//  AddSubtaskVC.swift
//  organizer
//
//  Created by Tevin Scott on 1/12/17.
//  Copyright © 2017 Tevin Scott. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class AddSubtaskTV: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    let DATAMANAGER = DataManager.init();
    var newSubtaskArray = [SubTaskCoreData]()
    var hasSubtasks: Bool = false;
    var parentTask: TaskCoreData?
    //intializer
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isScrollEnabled = false
        self.dataSource = self
        self.delegate = self
    }
    public func clearList(){
        newSubtaskArray = [SubTaskCoreData]()
        reloadData()
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : AddSubtaskTVCell
        cell = self.dequeueReusableCell(withIdentifier: "subtaskCell", for: indexPath) as! AddSubtaskTVCell
        
        //this if block is used for the initial adding of the first subtask
        //without it the 2nd task created will have the contents of the previous task's subtasks
        if(indexPath.row == tableView.numberOfRows(inSection: 0) - 1 || newSubtaskArray.count == 0){
            cell.subtaskTitleField.text = ""
            cell.subtaskTitleField.placeholder = "(Optional) add subtask description lol"
            cell.addSTButton.setImage(UIImage(named:"light check"), for: .normal)
            cell.addedToList = false;
            
            cell.subtaskTitleField.isUserInteractionEnabled = true
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.addSTButton.tag = indexPath.row
        cell.addSTButton.addTarget(self, action: #selector(self.checkButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        return cell
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newSubtaskArray.count + 1
        
        
    }
    /*
     *controls the set of buttons in the subtask table
     *adds the new subtask if the subtask has not been added
     *otherwise removes the 
     */
    func checkButtonClicked(sender:UIButton) {
        let buttonRow = sender.tag
        let cellhandle : AddSubtaskTVCell =
            self.cellForRow(at: IndexPath(row: buttonRow, section: 0)) as! AddSubtaskTVCell
        //checks textfield to see if it has text before adding it to the sub task list
        if(newSubtaskArray.count <= 6 && (cellhandle.subtaskTitleField.text?.characters.count)! > 0){
            //if the chosen button is either a current element or a new value
            //new element condition
            let newSubtaskElement = NSEntityDescription.insertNewObject(forEntityName: "SubTaskCoreData", into: DATAMANAGER.context) as! SubTaskCoreData;
            if(!cellhandle.addedToList && newSubtaskArray.count <= 5){
                cellhandle.subtaskTitleField.isUserInteractionEnabled = false;
                cellhandle.addedToList = true;
                newSubtaskElement.subTitle = cellhandle.subtaskTitleField.text
                cellhandle.addSTButton.setImage(UIImage(named: "removeSubtaskIcon"), for: .normal);

                newSubtaskArray.append(newSubtaskElement);
            }
            //existing element conition
            else if(cellhandle.addedToList){
                cellhandle.addedToList = false
                cellhandle.addSTButton.setImage(UIImage(named:"light check"), for: .normal);
                cellhandle.subtaskTitleField.text = "";
                cellhandle.subtaskTitleField.placeholder = "(Optional) add subtask description";
                newSubtaskArray.remove(at: buttonRow);
                DATAMANAGER.context.delete(newSubtaskElement);
                
                newSubtaskArray = DATAMANAGER.getSubTasks(parentTask: parentTask!)
                self.deleteRows(at: [IndexPath(row: buttonRow, section: 0)], with: UITableViewRowAnimation.fade);
                
            }
            self.reloadData()
        }
    }
}
