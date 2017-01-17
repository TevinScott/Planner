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
    var newSubtaskArray = [String]()
    @IBOutlet weak var mainTV: TaskTV!
    @IBOutlet weak var addTaskView: UIView!
    @IBOutlet weak var taskTitleField: UITextField!
    @IBOutlet weak var addSubtaskTableView: AddSubtaskTV!
    @IBOutlet weak var addReminder: UIButton!
    @IBOutlet weak var cancelAddReminderButton: UIButton!
    @IBOutlet weak var completeAddReminderButton: UIButton!
    
    @IBOutlet weak var Scheduler: UIView!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
    var blurEffectView: UIVisualEffectView?
    var isNotEmpty: Bool = true
    var isDateEnabled = false;
    
    @IBAction func cancelAddReminder(_ sender: UIButton) {
        Scheduler.isHidden = true
        self.view.sendSubview(toBack: Scheduler)
    }
    @IBAction func completeAddReminder(_ sender: UIButton) {
        Scheduler.isHidden = true
        self.view.sendSubview(toBack: Scheduler)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTV.separatorStyle = .none
        // Do any additional setup after loading the view, typically from a nib.
        addTaskView.isHidden = true
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ListVC.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        Scheduler.isHidden = true
        roundButtonCorners()
        view.addGestureRecognizer(tap)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newTaskData = NSEntityDescription.insertNewObject(forEntityName: "TaskCoreData", into: context)
        
        newTaskData.setValue("All", forKey: "category")
        newTaskData.setValue(0, forKey: "hasSubtasks")
        newTaskData.setValue(0, forKey: "isExpanded")
        newTaskData.setValue("hello Database", forKey: "title")
        
        do{
            try context.save()
            print("saved")
        }
        catch{
            
        }
        
    }
    func seedTaskData(){
        
    }

    @IBAction func addReminder(_ sender: UIButton) {
        Scheduler.isHidden = false

        self.view.bringSubview(toFront: Scheduler)
        Scheduler.clipsToBounds = true // must be set to true to allow rounded corners
        Scheduler.layer.cornerRadius = 12
        print("tapped")
    }
    
    @IBAction func addTask(_ sender: UIButton) {
        /*
        addTaskView.layer.borderWidth = 2
        addTaskView.layer.borderColor = UIColor.lightGray.cgColor
         */
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            //self.view.backgroundColor = UIColor.clear
            blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            //always fill the view
            blurEffectView?.frame = self.view.bounds
            blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.view.addSubview(blurEffectView!) //if you have more UIViews, use an insertSubview API to place it
            addTaskView.layer.cornerRadius = 12
            addTaskView.isHidden = false
            self.view.addSubview(addTaskView)
        } else {
            //self.view.backgroundColor = UIColor.black
        }

    }
    
    @IBAction func addToList(_ sender: UIButton) {
        if((taskTitleField.text?.characters.count)! > 0 && newSubtaskArray.count == 0){
            newSubtaskArray = addSubtaskTableView.newSubtaskArray
            if(!isDateEnabled && newSubtaskArray.count == 0){
                let newTask = Task("All",(taskTitleField.text)!)
                mainTV.taskList.append(newTask)
                addSubtaskTableView.clearList()
                
            }
            
            else if(newSubtaskArray.count != 0 && !isDateEnabled){
                let newTask = Task("All",(taskTitleField.text)!, newSubtaskArray)
                mainTV.taskList.append(newTask)
            }
            mainTV.reloadData()
            closeAddTask()
            self.view.endEditing(true)
        }
        
    }
    @IBAction func closeAddTaskView(_ sender: UIButton) {
        closeAddTask()
    }
    
    @IBAction func backToCategories(_ sender: Any) {
        _ = self.navigationController?.popToRootViewController(animated: true)
        print("tapped back")
    }
    
    func closeAddTask(){
        taskTitleField.text? = ""
        newSubtaskArray = [String]()
        addSubtaskTableView.clearList()
        addTaskView.isHidden = true;
        blurEffectView?.removeFromSuperview()
        self.view.endEditing(true)
        
    }
    func roundButtonCorners(){
        cancelAddReminderButton.layer.cornerRadius = 6
        
        completeAddReminderButton.layer.cornerRadius = 6
    }
        //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

