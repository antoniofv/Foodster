//
//  GroceryListViewModel.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 24/2/23.
//

import CoreData
import Foundation


final class GroceryListViewModel: NSObject, ObservableObject {

    @Published
    var groceries: [GroceryListItem] = []

    private let context: NSManagedObjectContext

    // The view model will keep 'groceries' updated through the NSFetchedResultsController.
    private let groceriesController: NSFetchedResultsController<GroceryListItem>


    init(context: NSManagedObjectContext) {
        self.context = context
        self.groceriesController = NSFetchedResultsController(
            fetchRequest: GroceryListItem.fetchRequest(),
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)

        super.init()

        self.groceriesController.delegate = self

        do {
            try self.groceriesController.performFetch()
            groceries = self.groceriesController.fetchedObjects ?? []
        } catch {
            print("failed to fetch grocery list items!")
        }
    }

}


// MARK: - Public functions

extension GroceryListViewModel {

    func createItem() -> GroceryListItem {
        let newItem = GroceryListItem(
            context: self.context,
            name: "",
            order: self.groceries.count
        )

        save()

        return newItem
    }

    func removeItem(atOffsets indexSet: IndexSet) {
        var newGroceries = Array(self.groceries)
        let item = newGroceries.remove(at: indexSet.first!)

        self.context.perform {
            self.context.delete(item)

            self.updateListItemOrdering(items: newGroceries)

            self.save()
        }
    }

    func moveItem(fromOffsets from: IndexSet, toOffset to: Int) {
        var newArray = Array(self.groceries)
        newArray.move(fromOffsets: from, toOffset: to)

        updateListItemOrdering(items: newArray)

        save()
    }

    func save() {
        if !self.context.hasChanges {
            return
        }

        Task {
            await self.context.perform {
                do {
                    try self.context.save()
                } catch {
                    print(error)
                }
            }
        }
    }

}


// MARK: - Private functions

extension GroceryListViewModel {

    private func updateListItemOrdering(items: [GroceryListItem]) {
        // FIXME: This is the most inefficient way to reorder.
        items.enumerated().forEach { (index, element) in
            element.order = index
        }
    }

}


// MARK: - NSFetchedResultsControllerDelegate

extension GroceryListViewModel: NSFetchedResultsControllerDelegate {

    func controllerDidChangeContent(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>
    ) {
        if let newGroceries = controller.fetchedObjects as? [GroceryListItem] {
            self.groceries = newGroceries
        }
    }

}
