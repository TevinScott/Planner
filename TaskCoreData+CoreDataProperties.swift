//
//  TaskCoreData+CoreDataProperties.swift
//  
//
//  Created by Tevin Scott on 1/17/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension TaskCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskCoreData> {
        return NSFetchRequest<TaskCoreData>(entityName: "TaskCoreData");
    }

    @NSManaged public var alertDate: NSDate?
    @NSManaged public var category: String?
    @NSManaged public var hasSubtasks: Bool
    @NSManaged public var isExpanded: Bool
    @NSManaged public var title: String?

}
