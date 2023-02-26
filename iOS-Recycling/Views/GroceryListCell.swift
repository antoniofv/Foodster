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
            TextField("", text: $groceryListItem.name)
                .font(.body)
                .bold()
                .background(isEditing ? .orange : .clear)
            Text("\(groceryListItem.quantity)")
                .multilineTextAlignment(.trailing)
        }
        .padding(EdgeInsets(top: 3, leading: 12, bottom: 3, trailing: 12))
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
