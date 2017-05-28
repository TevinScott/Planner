//
//  TaskCoreData+CoreDataProperties.swift
//  
//
//  Created by Tevin Scott on 5/27/17.
//
//

import Foundation
import CoreData


extension TaskCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskCoreData> {
        return NSFetchRequest<TaskCoreData>(entityName: "TaskCoreData")
    }

    @NSManaged public var alertDate: NSDate?
    @NSManaged public var category: String?
    @NSManaged public var hasSubtasks: Bool
    @NSManaged public var isExpanded: Bool
    @NSManaged public var title: String?
    @NSManaged public var subTasks: SubTaskCoreData?

}
