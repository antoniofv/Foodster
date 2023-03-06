//
//  GroceryListCell.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 25/2/23.
//

import SwiftUI

struct GroceryListCell: View {
    
    @Binding var groceryListItem: GroceryListItem
    var focusState: FocusState<UUID?>.Binding
    
    var isEditing: Bool = false
    
    private let hPadding = 16.0

    var body: some View {
        let isChecked = groceryListItem.isChecked
        HStack(alignment: .center) {
            Button(action: {
                groceryListItem.isChecked.toggle()
            }) {
                Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
            }
            .foregroundColor(isChecked ? .gray : .green)
            
            TextField("", text: $groceryListItem.name)
                .font(.body)
                .foregroundColor(isChecked ? .gray : nil)
                .focused(focusState, equals: groceryListItem.id)
        }
        .listRowBackground(isChecked ? Color.clear : Color.white)
        .padding(EdgeInsets(top: 0, leading: hPadding, bottom: 0, trailing: hPadding))
    }

}

#if DEBUG
struct GroceryListCell_Previews: PreviewProvider {
    @State private static var item = GroceryListItem(name: "")
    @FocusState static var focus: UUID?
    
    static var previews: some View {
        GroceryListCell(groceryListItem: $item, focusState: $focus)
    }
}
#endif
