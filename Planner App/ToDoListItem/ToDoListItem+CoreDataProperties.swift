//
//  ToDoListItem+CoreDataProperties.swift
//  Planner App
//
//  Created by Taylor Ngo on 6/19/21.
//
//

import Foundation
import CoreData


extension ToDoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var subject: String?
    @NSManaged public var date: Date?

}

extension ToDoListItem : Identifiable {

}
