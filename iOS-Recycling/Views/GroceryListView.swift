//
//  GroceryListView.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 24/2/23.
//

import SwiftUI

struct GroceryListViewData: Hashable {
    static func == (lhs: GroceryListViewData, rhs: GroceryListViewData) -> Bool {
        lhs.groceryListItem.wrappedValue == rhs.groceryListItem.wrappedValue
        && lhs.isChecked == rhs.isChecked
        && lhs.isEditing == rhs.isEditing
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.groceryListItem.wrappedValue)
        hasher.combine(self.isChecked)
        hasher.combine(self.isEditing)
    }
    
    var groceryListItem: Binding<GroceryListItem>
    var isChecked: Bool = false
    var isEditing: Bool = false
}

struct GroceryListView: View {
    
    @StateObject private var groceryListViewModel = GroceryListViewModel()
    @FocusState private var focusedIndex: Int?
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(groceryListViewModel.groceries.indices, id: \.self) { index in
                    GroceryListCell(
                        groceryListItem: $groceryListViewModel.groceries[index],
                        isEditing: (focusedIndex ?? -1) == index
                    )
                    .focused($focusedIndex, equals: index)
                    .onSubmit {
                        focusedIndex = nil
                    }
                }
                .onDelete { indexSet in
                    groceryListViewModel.removeItem(atOffsets: indexSet)
                }
            }
            .listStyle(.plain)
            .listRowSeparator(.visible)
            .navigationBarTitle(Text("Groceries"))
            .toolbarBackground(Color.green, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem {
                    Button("Add", action: addItem)
                        .foregroundColor(.white)
                        .bold()
                }
            }
        }
    }
    
    private func addItem() {
        groceryListViewModel.addItem(
            GroceryListItem(
                id: "\(groceryListViewModel.groceries.count)",
                name: "",
                quantity: 1
            )
        )
        focusedIndex = groceryListViewModel.groceries.count - 1
    }
}

#if DEBUG
struct GroceryListView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryListView()
    }
}
#endif
