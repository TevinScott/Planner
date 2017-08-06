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

    init() {
        context = appDelegate.persistentContainer.viewContext
    }
    func giveContext() -> NSManagedObjectContext{
        return context;
    }
    func getData() -> [TaskCoreData]{
        var storedTasks: [TaskCoreData] = [];
        var rawArray: [TaskCoreData] = [];
        let taskFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskCoreData")
        do{
            rawArray = try context.fetch(taskFetch) as! [TaskCoreData]
        }catch {}
        for task in rawArray {
            if(task.title != nil){
                storedTasks.append(task)
            }
        }
        
        return storedTasks;
    }
    /**
    
    */
    func saveData(standardTask: TaskCoreData, subtaskList: [SubTaskCoreData]){
        if(subtaskList.count > 0){
            for subTaskElement in subtaskList {
                subTaskElement.parentTask = standardTask;
            }
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    func saveData(){
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    /**
    
     */
    func getSubTasks(parentTask: TaskCoreData) -> [SubTaskCoreData] {
        var subtaskList = [SubTaskCoreData]();
        let subtaskPredicate = NSPredicate(format: "parentTask == %@", parentTask)//*must use the name of the attribute* *the more you know :D*
        let fetchSubtasks = NSFetchRequest<NSFetchRequestResult>(entityName: "SubTaskCoreData");
        fetchSubtasks.predicate = subtaskPredicate
        do {
             subtaskList = try context.fetch(fetchSubtasks) as! [SubTaskCoreData];
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        //print("total amount of children subtasks \(subtaskList.count)")

        return subtaskList;
    }
    func deleteSubTask(subtask: SubTaskCoreData){
        context.delete(subtask);
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    func deleteTask(taskToBeDeleted: TaskCoreData){
        context.delete(taskToBeDeleted)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }

    
    func DeleteAll(){
        // Initialize Fetch Request
        let taskFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskCoreData")
        let subtaskFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "SubTaskCoreData")
        // Configure Fetch Request
        taskFetch.includesPropertyValues = false
        subtaskFetch.includesPropertyValues = false
        do {
            let items = try context.fetch(taskFetch) as! [NSManagedObject]
            
            for item in items {
                context.delete(item)
            }
            // Save Changes
            try context.save()
        } catch {

        }
    }
}
