//
//  TodoItem+CoreDataClass.swift
//  TodoApp
//
//  Created by Baher Tamer on 26/11/2022.
//

import CoreData
import Foundation

@objc(TodoItem)
public class TodoItem: NSManagedObject {

    public override func awakeFromInsert() {
        self.dateCreated = Date()
        self.isCompleted = false
    }

    static func getTodoItemById(_ id: NSManagedObjectID) -> TodoItem {
        let viewContext = CoreDataManager.shared.viewContext
        guard let todoItem = viewContext.object(with: id) as? TodoItem else {
            fatalError("Id not found.")
        }

        return todoItem
    }
}
