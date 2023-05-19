//
//  GroceryListCell.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 25/2/23.
//

import SwiftUI


struct GroceryListCell: View {

    @ObservedObject var groceryListItem: GroceryListItem
    var focusState: FocusState<UUID?>.Binding

    var isEditing: Bool = false

    var body: some View {
        let isChecked = groceryListItem.isChecked

        HStack(alignment: .center) {
            Button(action: {
                groceryListItem.isChecked.toggle()
            }) {
                Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                    .resizable()
            }
            .frame(width: 20, height: 20)
            .buttonStyle(.borderless)  // Needed to prevent button's tap target to cover the whole cell.
            .foregroundColor(isChecked ? .gray : .green)

            TextField("", text: $groceryListItem.name)
                .font(.body)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(isChecked ? .gray : nil)
                .focused(focusState, equals: groceryListItem.id)
        }
        .listRowBackground(isChecked ? Color.clear : Assets.Colors.groceryListCellBackgroundActive)
        .padding(.zero.insetBy(horizontal: 16))
    }

}


#if DEBUG

struct GroceryListCell_Previews: PreviewProvider {
    
    static var previews: some View {
        let provider = DataStoreProvider(inMemory: true)

        @State var item = GroceryListItem(
            context: provider.container.viewContext,
            name: "My grocery list item",
            order: 0
        )
        @FocusState var focus: UUID?

        return GroceryListCell(groceryListItem: item, focusState: $focus)
            .environment(\.managedObjectContext, provider.container.viewContext)
    }
}

#endif
