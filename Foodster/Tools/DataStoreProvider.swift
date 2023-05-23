//
//  DataStoreProvider.swift
//  Foodster
//
//  Created by Antonio Fernandez Vega on 15/3/23.
//

import CoreData
import Foundation


class DataStoreProvider: ObservableObject {

    static var shared = {
        // This check is required due to Intent access to the storage.
        let inMemory = CommandLine.arguments.contains("-inMemoryDatabase")
        return DataStoreProvider(inMemory: inMemory)
    }()

    let container = NSPersistentContainer(name: "Foodster")


    init(inMemory: Bool = false) {
        if inMemory {
            container.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error {
                print("Data Store could not be initialized: \(error.localizedDescription)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }

}
