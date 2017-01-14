//
//  Task.swift
//  organizer
//
//  Created by Tevin Scott on 1/12/17.
//  Copyright © 2017 Tevin Scott. All rights reserved.
//

import Foundation
class Task {
    var category : String? = nil
    var title: String? = nil
    var alertDate: NSDate? = nil
    var subtasks: [String]? = nil
    var hasSubtask: Bool = false
    var isExpanded: Bool = false
    init(_ _category: String, _ _title: String){
        category = _category
        title = _title
    }
    init(_ _category: String, _ _title: String, _ _alertDate: NSDate){
        category = _category
        title = _title
        alertDate = _alertDate
        
    }
    init(_ _category: String, _ _title: String, _ _subtasks: [String]){
        category = _category
        title = _title
        subtasks = _subtasks
        hasSubtask = true
    }
    init(_ _category: String, _ _title: String, _ _alertDate: NSDate,_ _subtasks: [String]){
        category = _category
        title = _title
        alertDate = _alertDate
        subtasks = _subtasks
        hasSubtask = true
        
    }
}
