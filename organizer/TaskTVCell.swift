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
    var TaskObj : Task?
    var hasAlert: Bool = false;
    var hasSubtasks: Bool = false;
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var viewAlert: UIButton!
    @IBOutlet weak var viewAlertIcon: UIImageView!
    @IBOutlet weak var viewSubtask: UIButton!
    @IBOutlet weak var viewSubtaskIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func titleOnly(){
        viewAlert.removeFromSuperview()
        viewAlertIcon.removeFromSuperview()
        viewSubtask.removeFromSuperview()
        viewSubtaskIcon.removeFromSuperview()
    }
    func titleAndAlert(){
        viewSubtask.removeFromSuperview()
        viewSubtaskIcon.removeFromSuperview()
    }
    func titleAndSubtasks(){
        viewAlert.removeFromSuperview()
        viewAlertIcon.removeFromSuperview()
    }
}
