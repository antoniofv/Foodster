//
//  GroceryListItem.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 24/2/23.
//

import CoreData
import Foundation


@objc(GroceryListItem)
class GroceryListItem: NSManagedObject {

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var isChecked: Bool
    @NSManaged public var order: Int


    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryListItem> {
        let request = NSFetchRequest<GroceryListItem>(entityName: "GroceryListItem")
        request.sortDescriptors = [
            NSSortDescriptor(key: "order", ascending: true)
        ]
        return request
    }


    // Main initalizer

    convenience init(
        context: NSManagedObjectContext,
        id: UUID = UUID(),
        name: String,
        isChecked: Bool = false,
        order: Int
    ) {
        let entity = NSEntityDescription.entity(
            forEntityName: "GroceryListItem",
            in: context
        )!
        self.init(entity: entity, insertInto: context)
        self.id = id
        self.name = name
        self.isChecked = isChecked
        self.order = order
    }

}


extension GroceryListItem : Identifiable {

}
