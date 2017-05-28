//
//  DataManager.swift
//  organizer
//
//  Created by Tevin Scott on 1/17/17.
//  Copyright © 2017 Tevin Scott. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class DataManager {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext
    var newTaskData: NSManagedObject?
    var counterVal : Int32?
    var newCounterVal: NSManagedObject?
    init() {
        context = appDelegate.persistentContainer.viewContext
        _ = self.getData();
        
    }
    func giveContext() -> NSManagedObjectContext{
        return context;
    }
    func getData() -> [TaskCoreData]{
        let taskListRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"TaskCoreData")
        taskListRequest.returnsObjectsAsFaults = false
        var storedTasks: [TaskCoreData] = [];
       
        do{
             storedTasks = try context.fetch(TaskCoreData.fetchRequest())
        }catch {}
        return storedTasks;
    }
    
    func saveData(standardTask: TaskCoreData, subtaskList: [String]){
        if(subtaskList.count > 0){
            for subTitle in subtaskList {
                let subTaskCD = NSEntityDescription.insertNewObject(forEntityName: "SubTaskCoreData", into: context) as! SubTaskCoreData
                subTaskCD.subTitle = subTitle;
                subTaskCD.parentTask = standardTask;
            }
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    func getSubTasks(parentTask: TaskCoreData) -> [String] {
        var subtaskList = [String]();
        // loop through getting tasks associated with the parent task
        return subtaskList;
    }
    func deleteSubTask(subtask: SubTaskCoreData){
        context.delete(subtask);
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    func deleteTask(taskToBeDeleted: TaskCoreData){
        context.delete(taskToBeDeleted)
        print("task being deleted: \(taskToBeDeleted.title)")
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }

    
    func DeleteAll(){
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskCoreData")
        
        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false
        
        do {
            let items = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            for item in items {
                context.delete(item)
            }
            
            // Save Changes
            try context.save()
            
        } catch {
            // Error Handling
            // ...
        }
    }
}
