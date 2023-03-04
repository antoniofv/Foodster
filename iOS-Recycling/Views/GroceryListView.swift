//
//  GroceryListView.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 24/2/23.
//

import SwiftUI

struct GroceryListView: View {
    
    @StateObject private var groceryListViewModel = GroceryListViewModel()
    @FocusState private var focusedItem: UUID?
    
    var body: some View {
        NavigationStack {
            List() {
                Section {
                    ForEach($groceryListViewModel.groceries, id: \.id) {
                        GroceryListCell(
                            groceryListItem: $0,
                            isEditing: focusedItem == $0.id
                        )
                        .focused($focusedItem, equals: $0.id)
                        .onSubmit {
                            focusedItem = nil
                        }
                        
                    }
                    .onDelete { indexSet in
                        groceryListViewModel.removeItem(atOffsets: indexSet)
                    }
                    .onMove { from, to in
                        groceryListViewModel.moveItem(fromOffsets: from, toOffset: to)
                    }
                }
            }
            .listStyle(.plain)
            .listRowSeparator(.visible)
            .navigationBarTitle(Text("Groceries"))
            .toolbarBackground(Color.green, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .background(.gray.opacity(0.15))
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        withAnimation {
                            addItem()
                        }
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                    }
                }
            }
            .overlay(Group {
                // Empty list view
                if groceryListViewModel.groceries.isEmpty {
                    Text("Add some items to the list!")
                        .font(.title2)
                        .foregroundColor(Color(white: 0.4))
                }
            })
        }
    }
    
    private func addItem() {
        let newItem = GroceryListItem(name: "")
        groceryListViewModel.addItem(newItem)
        focusedItem = newItem.id
    }
}

#if DEBUG
struct GroceryListView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryListView()
    }
}
#endif
