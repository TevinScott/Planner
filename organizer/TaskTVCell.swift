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
    var taskObj : TaskCoreData?
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
        super.awakeFromNib();
        self.isUserInteractionEnabled = true;
        self.selectionStyle = .none;
    }
    func setAll(){
        hasSubtasks = true
        //subtaskTableView.subtaskList = (taskObj?.subtaskList)! as! [String]
        //resizing
        var frameRect = taskTitle.frame;
        frameRect.size.width = 300; // <-- Specify the width you want here.
        taskTitle.frame = frameRect;
        //end of resizing
        //set element values
        taskTitle.text = taskObj?.title
        viewAlertIcon.image = UIImage(named:"alertIconSet")
        
    }
    public func setCellElements(){
        if(!(taskObj?.hasSubtasks)! && taskObj?.alertDate == nil){
            titleOnly()
        }
        else if(taskObj?.alertDate != nil && taskObj?.hasSubtasks == false ){
            titleAndAlert()
        }
        else if((taskObj?.hasSubtasks)! && taskObj?.alertDate == nil ){
            titleAndSubtasks()
        }
        else if((taskObj?.hasSubtasks)! && taskObj?.alertDate != nil){
            setAll();
        }

    }
    private func titleOnly(){
            taskTitle.text = "";
            //remove unecessary elements
        if(viewAlert != nil){ viewAlert.removeFromSuperview(); }
        if(viewAlertIcon != nil){ viewAlertIcon.removeFromSuperview(); }
        if(viewSubtask != nil) { viewSubtask.removeFromSuperview(); }
        if(viewSubtaskIcon != nil) {viewSubtaskIcon.removeFromSuperview(); }
        if(subtaskTableView != nil) {subtaskTableView.removeFromSuperview(); }
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
    func allSubtasksCompleted(){
        //taskObj?.subtaskList = nil
        hasSubtasks = false;
        setCellElements()
    }
    
    private func titleAndSubtasks(){
        if(viewAlert != nil){
            viewAlert.removeFromSuperview()
            viewAlertIcon.removeFromSuperview()
        }
        hasSubtasks = true
        //subtaskTableView.subtaskList = (taskObj?.subtaskList)! as! [String]
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
