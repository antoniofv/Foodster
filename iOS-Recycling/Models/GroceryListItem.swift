//
//  GroceryListItem.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 24/2/23.
//

import Foundation

struct GroceryListItem: Identifiable, Hashable {
    var id: String
    let name: String
    var quantity: Int
}
