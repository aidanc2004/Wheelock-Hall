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
                
                if item.desc != "~" {
                    Text(itemDescription())
                        .foregroundColor(.gray)
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
            
            Text("Ingredients:")
                .font(.headline)
            
            let ingredientArray = item.ingredients.components(separatedBy: ", ")
            
            List(ingredientArray, id: \.self) { ingredient in
                Text(ingredient)
            }
        }
    }
    
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
