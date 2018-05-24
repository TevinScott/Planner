//
//  ViewController.swift
//  organizer
//
//  Created by Tevin Scott on 1/8/17.
//  Copyright © 2017 Tevin Scott. All rights reserved.
//

import UIKit
import FSCalendar
import CoreData
class ListVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource{
   
    var newSubtaskArray = [SubTaskCoreData]();
    @IBOutlet weak var mainTV: TaskTV!;
    @IBOutlet weak var addTaskView: UIView!;
    @IBOutlet weak var taskTitleField: UITextField!
    @IBOutlet weak var addSubtaskTableView: AddSubtaskTV!;
    @IBOutlet weak var addReminder: UIButton!;
    @IBOutlet weak var cancelAddReminderButton: UIButton!;
    @IBOutlet weak var completeAddReminderButton: UIButton!;
    @IBOutlet weak var Scheduler: UIView!;
    @IBOutlet weak var timePicker: UIDatePicker!;
    @IBOutlet weak var calender: FSCalendar!
    var newTempTask: TaskCoreData? = nil;
    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark);
    var blurEffectView: UIVisualEffectView?;
    var isNotEmpty: Bool = true;
    var isReminderSet = false;
    let DATAMANAGER = DataManager.init();

    
    override func viewDidLoad() {
        super.viewDidLoad();
        mainTV.separatorStyle = .none;
        // Do any additional setup after loading the view, typically from a nib.
        addTaskView.isHidden = true;
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ListVC.dismissKeyboard));
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false;
        Scheduler.isHidden = true;
        roundButtonCorners();
        view.addGestureRecognizer(tap);
        //testTaskArray.append(task1);
        //testTaskArray.append(task2);
        mainTV.taskList = DATAMANAGER.getData();
        mainTV.reloadData();
        
    }

    @IBAction func cancelAddReminder(_ sender: UIButton) {
        
        Scheduler.isHidden = true
        self.view.sendSubview(toBack: Scheduler)
    }
    @IBAction func completeAddReminder(_ sender: UIButton) {
        Scheduler.isHidden = true
        self.view.sendSubview(toBack: Scheduler)
    }
    
    @IBAction func addReminder(_ sender: UIButton) {
        Scheduler.isHidden = false;
        isReminderSet = true;
        self.view.bringSubview(toFront: Scheduler);
        Scheduler.clipsToBounds = true; // must be set to true to allow rounded corners
        Scheduler.layer.cornerRadius = 12;
    }
    
    @IBAction func addTask(_ sender: UIButton) {
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            //self.view.backgroundColor = UIColor.clear;
            blurEffectView = UIVisualEffectView(effect: blurEffect);
            
            //always fill the view
            blurEffectView?.frame = self.view.bounds;
            blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight];
            newTempTask = NSEntityDescription.insertNewObject(forEntityName: "TaskCoreData", into: DATAMANAGER.context) as? TaskCoreData
            self.view.addSubview(blurEffectView!) //if you have more UIViews, use an insertSubview API to place it
            addTaskView.layer.cornerRadius = 12;
            addTaskView.isHidden = false;
            self.view.addSubview(addTaskView);
        }

    }
    
    @IBAction func addToList(_ sender: UIButton) {
        if((taskTitleField.text?.characters.count)! > 0){
            newSubtaskArray = addSubtaskTableView.newSubtaskArray;
            
            addSubtaskTableView.parentTask = newTempTask;
            newTempTask?.category = "All";
            newTempTask?.title = taskTitleField.text;
            if(isReminderSet){
                //newTask.alertDate = need to get date/time values from FSCalender(date only) and UIDatepicker(time only)
                newTempTask?.alertDate = calender.selectedDate as NSDate
            }
            if(newSubtaskArray.count > 0){
                newTempTask?.hasSubtasks = true;
            }
            DATAMANAGER.saveData(standardTask: newTempTask!, subtaskList: newSubtaskArray);
            newTempTask = nil;
            isReminderSet = false;
            mainTV.taskList = DATAMANAGER.getData();
            addSubtaskTableView.clearList();
            mainTV.reloadData();
            closeAddTask();
            self.view.endEditing(true);
        }
        
    }
    
    @IBAction func closeAddTaskView(_ sender: UIButton) {
        DATAMANAGER.context.delete(newTempTask!);
        DATAMANAGER.DeleteAll();
        closeAddTask();
    }
    
    @IBAction func backToCategories(_ sender: Any) {
        _ = self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    func closeAddTask(){
        taskTitleField.text? = "";
        newSubtaskArray = [SubTaskCoreData]();
        newTempTask = nil;
        addSubtaskTableView.clearList();
        addTaskView.isHidden = true;
        blurEffectView?.removeFromSuperview();
        self.view.endEditing(true);
    }
    
    func roundButtonCorners(){
        cancelAddReminderButton.layer.cornerRadius = 6;
        
        completeAddReminderButton.layer.cornerRadius = 6;
    }
    
    func dismissKeyboard() {
        view.endEditing(true);
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
    
}

