//
//  GroceryListCell.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 25/2/23.
//

import SwiftUI

struct GroceryListCell: View {
    @Binding var groceryListItem: GroceryListItem
    
    @State var isChecked: Bool = false
    @State var isEditing: Bool = false
    
    var body: some View {
        HStack(alignment: .center) {
            Button(action: {
                isChecked = !isChecked
            }) {
                Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
            }.foregroundColor(isChecked ? .gray : nil)
            TextField("", text: $groceryListItem.name)
                .font(.body)
                .bold()
                .foregroundColor(isChecked ? .gray : nil)
        }.listRowBackground(isChecked ? Color.clear : Color.white)
    }
}

#if DEBUG
struct GroceryListCell_Previews: PreviewProvider {
    @State private static var item = GroceryListItem(id: "1", name: "", quantity: 1)
    static var previews: some View {
        GroceryListCell(groceryListItem: $item)
    }
}
#endif
