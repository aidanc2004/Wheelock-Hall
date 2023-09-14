//
//  MenuModel.swift
//  Wheelock Hall
//
//  Created by Aidan Carey on 2023-07-18.
//

import Foundation

// represents json file
struct DineOnCampusAPI: Decodable {
    let menu: Menu
    let periods: [Period]
    
    struct Menu: Decodable {
        let periods: Periods
        
        struct Periods: Decodable {
            let categories: [Category]
        }
    }
}

// represents the list of periods, used for storing period ids
struct Period: Decodable {
    let id: String
    let name: String
    let sort_order: Int
}

// a category that contains different items
// (the grill house, the kitchen, etc)
struct Category: Decodable, Identifiable {
    let id: String
    let name: String
    let items: [Item]
    let sort_order: Int
}

// an individual item
struct Item: Decodable, Identifiable {
    let id: String
    let name: String
    let desc: String?
    let nutrients: [Nutrient]
    let ingredients: String
    let calories: Int
    let portion: String
}

// stores nutritional information about an item (protein, calories, etc)
struct Nutrient: Decodable {
    let name: String
    let value: String
    let uom: String // unit (i.e. 'g' for grams)
}
