//
//  TaskCoreData+CoreDataProperties.swift
//  
//
//  Created by Tevin Scott on 5/28/17.
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
    @NSManaged public var subtasks: NSSet?

}

// MARK: Generated accessors for subtasks
extension TaskCoreData {

    @objc(addSubtasksObject:)
    @NSManaged public func addToSubtasks(_ value: SubTaskCoreData)

    @objc(removeSubtasksObject:)
    @NSManaged public func removeFromSubtasks(_ value: SubTaskCoreData)

    @objc(addSubtasks:)
    @NSManaged public func addToSubtasks(_ values: NSSet)

    @objc(removeSubtasks:)
    @NSManaged public func removeFromSubtasks(_ values: NSSet)

}
