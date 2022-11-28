//
//  TodoCategory+CoreDataClass.swift
//  TodoApp
//
//  Created by Baher Tamer on 25/11/2022.
//

import CoreData
import Foundation

@objc(TodoCategory)
public class TodoCategory: NSManagedObject {
    
    public override func awakeFromInsert() {
        self.dateCreated = Date()
    }
    
    
    static var allCategories: NSFetchRequest<TodoCategory> {
        let request = TodoCategory.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        return request
    }

    static func getTodoCategoryById(_ id: NSManagedObjectID) -> TodoCategory {
        let viewContext = CoreDataManager.shared.viewContext
        guard let todoCategory = viewContext.object(with: id) as? TodoCategory else {
            fatalError("Id not found.")
        }

        return todoCategory
    }
    
    static func todoItemsByCategoryRequest(_ todoCategory: TodoCategory) -> NSFetchRequest<TodoItem> {
        let request = TodoItem.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        request.predicate = NSPredicate(format: "category = %@", todoCategory)
        return request
    }
}
