//
//  ItemView.swift
//  Wheelock Hall
//
//  Created by Aidan Carey on 2023-07-20.
//

import SwiftUI

struct ItemView: View {
    var item: Item
    @Binding var selected: String?
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.subheadline)
                
                // show item description if it exists
                if item.desc != "~" {
                    Text(itemDescription())
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                // show expanded item description if selected
                if selected == item.name {
                    Group {
                        Text("\(item.portion)")
                        Text("\(item.calories) cal")
                        // probably use seperate view for these
                        Text("Ingredients: TODO")
                        Text("Nutrients: TODO")
                    }
                    .font(.caption)
                }
            }
            
            Spacer()
        }
        .listRowBackground(backgroundColor())
        .contentShape(Rectangle())
        // TODO: make animation look better
        .animation(.spring(), value: selected)
    }
    
    // add grammer to item description
    func itemDescription() -> String {
        var description = item.desc
        
        // Add period the end of the description
        if !description.hasPrefix(".") {
            description.append(".")
        }
        
        let prefix = description.prefix(1)
        
        // Capitalize begining of description
        if prefix != prefix.capitalized {
            // remove prefix
            description.remove(at: description.startIndex)
            // insert new capitalized prefix
            description.insert(Character(prefix.capitalized), at: description.startIndex)
        }
        
        return description
    }
    
    // choose background color if item is selected
    func backgroundColor() -> Color {
        if selected == item.name {
            if colorScheme == .dark {
                return Color.gray.opacity(0.1)
            } else {
                return Color.white.opacity(0.5)
            }
        } else {
            if colorScheme == .dark {
                return Color.black
            } else {
                return Color.white
            }
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var item: Item = Item(id: "id",
        name: "Item Name",
        desc: "this is an item description",
        nutrients: [],
        calories: 123,
        portion: "1 each"
    )
    
    @State static var selected: String? = "hi"
    
    static var previews: some View {
        ItemView(item: item, selected: $selected)
    }
}
