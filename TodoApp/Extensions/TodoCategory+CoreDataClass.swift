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
}
