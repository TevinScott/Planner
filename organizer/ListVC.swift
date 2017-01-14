//
//  ViewController.swift
//  organizer
//
//  Created by Tevin Scott on 1/8/17.
//  Copyright © 2017 Tevin Scott. All rights reserved.
//

import UIKit

class ListVC: UIViewController{
    var newSubtaskArray = [String]()
    
    @IBOutlet weak var mainTV: TaskTV!
    @IBOutlet weak var addTaskView: UIView!
    @IBOutlet weak var taskTitleField: UITextField!
    @IBOutlet weak var addSubtaskTableView: AddSubtaskTV!
    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
    var blurEffectView: UIVisualEffectView?
    var isNotEmpty: Bool = true
    var isDateEnabled = false;
    
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
    
    func closeAddTask(){
        taskTitleField.text? = ""
        newSubtaskArray = [String]()
        isDateEnabled = false;
        addTaskView.isHidden = true;
        blurEffectView?.removeFromSuperview()
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTV.separatorStyle = .none
        // Do any additional setup after loading the view, typically from a nib.
        addTaskView.isHidden = true
        //Looks for single or multiple taps.
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ListVC.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        //view.addGestureRecognizer(tap)

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

