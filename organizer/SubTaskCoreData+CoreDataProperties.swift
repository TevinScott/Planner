//
//  SubTaskCoreData+CoreDataProperties.swift
//  
//
//  Created by Tevin Scott on 5/28/17.
//
//

import Foundation
import CoreData


extension SubTaskCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubTaskCoreData> {
        return NSFetchRequest<SubTaskCoreData>(entityName: "SubTaskCoreData")
    }

    @NSManaged public var subTitle: String?
    @NSManaged public var parentTask: TaskCoreData?

}
