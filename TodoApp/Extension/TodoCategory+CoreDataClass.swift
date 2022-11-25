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
        self.dataCreated = Date()
    }

}
