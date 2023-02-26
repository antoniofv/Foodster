//
//  GroceryListViewModel.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 24/2/23.
//

import Foundation

final class GroceryListViewModel: ObservableObject {
    
    @Published
    var groceries: [GroceryListItem] = []
    
    func addItem(_ item: GroceryListItem) {
        groceries.append(item)
    }
    
    func removeItem(_ item: GroceryListItem) {
        if let index = groceries.firstIndex(where: {$0.id == item.id}) {
            groceries.remove(at: index)
        }
    }
    
    func removeItem(atOffsets indexSet: IndexSet) {
        groceries.remove(atOffsets: indexSet)
    }
    
    func moveItem(fromOffsets from: IndexSet, toOffset to: Int) {
        groceries.move(fromOffsets: from, toOffset: to)
    }

}
