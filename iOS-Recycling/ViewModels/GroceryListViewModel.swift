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

    private unowned var context: NSManagedObjectContext

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

        groceriesController.delegate = self

        do {
            try groceriesController.performFetch()
            groceries = groceriesController.fetchedObjects ?? []
        } catch {
            print("failed to fetch grocery list items!")
        }
    }

}


// MARK: - Public functions

extension GroceryListViewModel {

    func createItem() -> GroceryListItem {
        let newItem = GroceryListItem(
            context: context,
            name: "",
            order: groceries.count
        )

        save()

        return newItem
    }

    func removeItem(atOffsets indexSet: IndexSet) {
        var newGroceries = Array(groceries)
        let item = newGroceries.remove(at: indexSet.first!)

        context.perform { [weak self] in
            guard let self else { return }

            context.delete(item)
            updateListItemOrdering(items: newGroceries)
        }

        save()
    }

    func moveItem(fromOffsets from: IndexSet, toOffset to: Int) {
        var newArray = Array(groceries)
        newArray.move(fromOffsets: from, toOffset: to)

        updateListItemOrdering(items: newArray)

        save()
    }

    func save() {
        if !context.hasChanges {
            return
        }

        Task {
            await context.perform { [weak self] in
                guard let self else { return }

                do {
                    try context.save()
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
            groceries = newGroceries
        }
    }

}
