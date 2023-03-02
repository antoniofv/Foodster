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
            }.foregroundColor(isChecked ? .gray : .green)
            TextField("", text: $groceryListItem.name)
                .font(.body)
                .foregroundColor(isChecked ? .gray : nil)
        }.listRowBackground(isChecked ? Color.clear : Color.white)
    }
}

#if DEBUG
struct GroceryListCell_Previews: PreviewProvider {
    @State private static var item = GroceryListItem(name: "")
    static var previews: some View {
        GroceryListCell(groceryListItem: $item)
    }
}
#endif
