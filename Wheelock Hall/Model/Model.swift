//
//  Model.swift
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

// maybe if this is always the same i can just save it once
// for the location (ex. wheelock)
struct Period: Decodable {
    let name: String
    let sort_order: Int
}

// the grill house, the kitchen, etc
struct Category: Decodable, Identifiable {
    let id: String
    let name: String
    let items: [Item]
    // the sort order might be the same as the period sort order,
    // meaning that i can use this to find out the period its in.
    // im not sure how this works yet because theres only one period
    // and category until september
    let sort_order: Int
}

// an individual food item
struct Item: Decodable, Identifiable {
    let id: String
    let name: String
    let desc: String
    let nutrients: [Nutrient]
    let ingredients: String
    let calories: Int
    let portion: String
}

// protein, calories, etc
struct Nutrient: Decodable {
    let name: String
    let value: String
    let uom: String // unit (i.e. 'g' for grams)
}
