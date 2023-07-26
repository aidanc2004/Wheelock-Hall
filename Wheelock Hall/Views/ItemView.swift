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
        /*
         NOTE: when i use ZStack over HStack it looks better, but it makes it
         so if the name is too long you cant go to the navigation link until
         expanded
        */
        ZStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(item.name.capitalized)
                    .font(.subheadline)
                
                // show item description if it exists
                if item.desc != "~" {
                    Text(item.desc.itemDescription())
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                // show expanded item description if selected
                if selected == item.name {
                    Group {
                        Text("\(item.portion)")
                        Text("\(item.calories) cal")
                    }
                    .transition(.opacity)
                    .font(.caption)
                }
            }
            .onTapGesture {
                selected = item.name
            }
            
            // show detailed view
            NavigationLink(destination: ItemDetailView(item: item)) {}
        }
        .listRowBackground(backgroundColor())
        .contentShape(Rectangle())
        .animation(.spring(), value: selected)
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
        name: "item name",
        desc: "this is an item description",
        nutrients: [],
        ingredients: "",
        calories: 123,
        portion: "1 each"
    )
    
    @State static var selected: String? = "hi"
    
    static var previews: some View {
        ItemView(item: item, selected: $selected)
    }
}
