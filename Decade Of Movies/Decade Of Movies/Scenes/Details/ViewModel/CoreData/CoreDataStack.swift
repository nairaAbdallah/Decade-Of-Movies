//
//  CoreDataStack.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 05/11/2023.
//

import UIKit
import CoreData

class CoreDataStack {
    // MARK: - shared
    public static var shared = CoreDataStack()
    // MARK: - Properties
    let persistentContainer: NSPersistentContainer
    let backgroundContext: NSManagedObjectContext
    let mainContext: NSManagedObjectContext
    let identifier: String  = "Naira.Decade-Of-Movies"   //bundle ID
    let model: String       = "PhotoSearchDataModel"     //Model name
    
    private init() {
        let messageKitBundle = Bundle(identifier: self.identifier)
        if let modelURL = messageKitBundle?.url(forResource: self.model, withExtension: "momd"),
           let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL) {
            persistentContainer = NSPersistentContainer(name: self.model, managedObjectModel: managedObjectModel)
        } else {
            persistentContainer = NSPersistentContainer(name: "model")
        }
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = NSSQLiteStoreType
        
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("❌ Loading of store failed:\(error)")
            }
        }
        
        mainContext = persistentContainer.viewContext
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        backgroundContext.parent = self.mainContext
    }
}

