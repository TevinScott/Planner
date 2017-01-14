//
//  CustomTableCell.swift
//  organizer
//
//  Created by Tevin Scott on 1/11/17.
//  Copyright © 2017 Tevin Scott. All rights reserved.
//

import Foundation
import UIKit
class TaskTVCell: UITableViewCell{
    var taskObj : Task?
    var hasAlert: Bool = false;
    var hasSubtasks: Bool = false;
    var isExpanded: Bool = false;
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var viewAlert: UIButton!
    @IBOutlet weak var viewAlertIcon: UIImageView!
    @IBOutlet weak var viewSubtask: UIButton!
    @IBOutlet weak var viewSubtaskIcon: UIImageView!
    @IBOutlet weak var subtaskTableView: SubtaskTV!
    
    //default cell height = 67
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = true
        self.selectionStyle = .none
    }
    
    public func setCellElements(){
        if(taskObj?.subtasks == nil && taskObj?.alertDate == nil){
            titleOnly()
            print("title only")
        }
        else if(taskObj?.alertDate != nil && taskObj?.subtasks == nil ){
            titleAndAlert()
            print("title and alert")
        }
        else if(taskObj?.subtasks != nil && taskObj?.alertDate == nil ){
            titleAndSubtasks()
            print("title and subtasks")
        }
    }
    private func titleOnly(){
        if(viewAlert != nil){
            //remove unecessary elements
            viewAlert.removeFromSuperview()
            viewAlertIcon.removeFromSuperview()
            viewSubtask.removeFromSuperview()
            viewSubtaskIcon.removeFromSuperview()
            subtaskTableView.removeFromSuperview()
            //end of removal
            //resizing
            var frameRect = taskTitle.frame;
            frameRect.size.width = 300; // <-- Specify the width you want here.
            
            taskTitle.frame = frameRect;
            taskTitle.frame.origin = CGPoint(x: 10, y: taskTitle.frame.height/2)
            //end of resizing
            //set element values
            taskTitle.text = taskObj?.title
        }
    }
    private func titleAndAlert(){
        //remove unecessary elements
        viewSubtask.removeFromSuperview()
        viewSubtaskIcon.removeFromSuperview()
        //end of removal
        //resizing
        var frameRect = taskTitle.frame;
        frameRect.size.width = 300; // <-- Specify the width you want here.
        taskTitle.frame = frameRect;
        //end of resizing
        //set element values
        taskTitle.text = taskObj?.title
        
    }
    private func titleAndSubtasks(){
        if(viewAlert != nil){
            viewAlert.removeFromSuperview()
            viewAlertIcon.removeFromSuperview()
        }
        hasSubtasks = true
        subtaskTableView.subtaskList = (taskObj?.subtasks)!
        //resizing
        var frameRect = taskTitle.frame;
        frameRect.size.width = 300; // <-- Specify the width you want here.
        taskTitle.frame = frameRect;
        taskTitle.frame.origin = CGPoint(x: 10, y: taskTitle.frame.height/2)
        //end of resizing
        //set element values
        taskTitle.text = taskObj?.title

    }
}
