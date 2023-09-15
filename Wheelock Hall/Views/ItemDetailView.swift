//
//  ItemDetailView.swift
//  Wheelock Hall
//
//  Created by Aidan Carey on 2023-07-22.
//

import SwiftUI

struct ItemDetailView: View {
    var item: Item
    
    var body: some View {
        VStack {
            VStack {
                Text(item.name.capitalized)
                    .font(.title)
                
                if let desc = item.desc {
                    if desc != "~" {
                        Text(desc.itemDescription())
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                }
                
                Text("\(item.portion), \(item.calories) calories.")
            }
            .padding()
            
            Text("Nutrients:")
                .font(.headline)
            
            List(item.nutrients, id: \.name) { nutrient in
                // dont display nutrients that are not there
                if nutrient.value != "-" && nutrient.value != "0" {
                    HStack {
                        Text(nutrient.name)
                        Spacer()
                        Text("\(nutrient.value) \(nutrient.uom)")
                    }
                }
            }
            .listStyle(.inset)
            
            VStack {
                Text("Ingredients:")
                    .font(.headline)
                
                if let ingredients = item.ingredients {
                    Text(ingredients)
                }
            }
            .padding()
        }
        .navigationSplitViewColumnWidth(300)
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var item: Item = Item(id: "id",
        name: "item name",
        desc: "this is an item description",
        nutrients: [
            Nutrient(name: "Name", value: "123", uom: "g"),
            Nutrient(name: "Name", value: "123", uom: "g"),
            Nutrient(name: "Name", value: "123", uom: "g"),
            Nutrient(name: "Name", value: "123", uom: "g"),
        ],
        ingredients: "Home Fries, Canola/Olive Oil Blend, Salt, Paprika, Black Pepper",
        calories: 123,
        portion: "1 each"
    )
    
    static var previews: some View {
        ItemDetailView(item: item)
    }
}
