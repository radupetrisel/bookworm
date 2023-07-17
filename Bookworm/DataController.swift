//
//  DataController.swift
//  Bookworm
//
//  Created by Radu Petrisel on 14.07.2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    static var preview = DataController(inMemory: true)
    
    let container = NSPersistentContainer(name: "Bookworm")
    
    init(inMemory: Bool = false) {
        if inMemory {
            container.persistentStoreDescriptions = [NSPersistentStoreDescription(url: URL(filePath: "/dev/null"))]
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData failed to load \(error.localizedDescription).")
            }
        }
    }
}
