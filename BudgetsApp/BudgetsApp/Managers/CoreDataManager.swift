//
//  CoreDataManager.swift
//  BudgetsApp
//
//  Created by  Vladyslav Fil on 17.03.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private var persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "BudgetModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Unable to initialze Core Data stack \(error)")
            }
        }
    }
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}
