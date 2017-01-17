//
//  SchedulerVC.swift
//  organizer
//
//  Created by Tevin Scott on 1/16/17.
//  Copyright © 2017 Tevin Scott. All rights reserved.
//

import Foundation
import UIKit
import FSCalendar

class SchedulerVC: UIView, FSCalendarDataSource, FSCalendarDelegate {
    
    
    
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBAction func addReminder(_ sender: UIButton) {
       
    }
    @IBAction func closeReminder(_ sender: UIButton) {
        self.view.isHidden = true;
        self.view.superview?.sendSubview(toBack: self.view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.datePickerMode = UIDatePickerMode.time
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
