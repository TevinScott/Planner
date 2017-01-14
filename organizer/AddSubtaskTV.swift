//
//  AddSubtaskVC.swift
//  organizer
//
//  Created by Tevin Scott on 1/12/17.
//  Copyright © 2017 Tevin Scott. All rights reserved.
//

import Foundation
import UIKit
class AddSubtaskTV: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    var newSubtaskArray = [String]()
    var hasSubtasks: Bool = false;
    //intializer
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isScrollEnabled = false
        self.dataSource = self
        self.delegate = self
    }
    public func clearList(){
        for i in 0 ... newSubtaskArray.count{
            // loop through deleting all cells to fully clear the table
        }
        //newSubtaskArray = [String]()
        
        reloadData()
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : AddSubtaskTVCell
        cell = self.dequeueReusableCell(withIdentifier: "subtaskCell", for: indexPath) as! AddSubtaskTVCell
        if(cell.subtaskTitleField.text!.characters.count != 0){
            cell.subtaskTitleField.placeholder = newSubtaskArray[indexPath.row]
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.addSTButton.tag = indexPath.row
        cell.addSTButton.addTarget(self, action: #selector(self.checkButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        /* here to stop the extra subview cell being added
        if(indexPath.row > 5){
            self.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
         */
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
            if(!cellhandle.addedToList && newSubtaskArray.count <= 5){
                cellhandle.subtaskTitleField.isUserInteractionEnabled = false
                cellhandle.addedToList = true
                cellhandle.addSTButton.setImage(UIImage(named: "removeSubtaskIcon"), for: .normal)
                newSubtaskArray.append( cellhandle.subtaskTitleField.text!)
                print(newSubtaskArray)
            }
            //existing element conition
            else if(cellhandle.addedToList){
                cellhandle.addedToList = false
                cellhandle.addSTButton.setImage(UIImage(named:"light check"), for: .normal)
                cellhandle.subtaskTitleField.text = ""
                cellhandle.subtaskTitleField.placeholder = "(Optional) add subtask description"
                newSubtaskArray.remove(at: buttonRow)
                self.deleteRows(at: [IndexPath(row: buttonRow, section: 0)], with: UITableViewRowAnimation.fade)
                
            }
            self.reloadData()
            print("subtask array size \(newSubtaskArray.count)")
        }
    }
}
