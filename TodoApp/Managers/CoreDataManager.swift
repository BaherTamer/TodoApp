//
//  CoreDataManager.swift
//  TodoApp
//
//  Created by Baher Tamer on 25/11/2022.
//

import CoreData
import Foundation

class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    private let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "TodoApp")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }

    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}
