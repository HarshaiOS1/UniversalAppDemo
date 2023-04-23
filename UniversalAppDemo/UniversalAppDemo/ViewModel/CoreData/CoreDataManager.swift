//
//  CoreDataManager.swift
//  UniversalAppDemo
//
//  Created by Harsha on 23/04/2023.
//

import Foundation
import CoreData

class CoreDataManager: NSObject {
    
    private override init() { }
    
    static let sharedContextManager:CoreDataManager = {
        let contextManager = CoreDataManager()
        let persistant = contextManager.persistentContainer
        return contextManager
    }()
    
    lazy var mainManagedObjectContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UniversalAppDemo")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()
    
    func removeAll() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
