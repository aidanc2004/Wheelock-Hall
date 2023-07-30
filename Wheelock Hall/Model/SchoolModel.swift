//
//  SchoolModel.swift
//  Wheelock Hall
//
//  Created by Aidan Carey on 2023-07-30.
//

import Foundation

// Schools

struct Schools: Decodable {
    let sites: [Site]
}

struct Site: Decodable {
    let id: String
    let name: String
    let slug: String // search by this
}

// Locations

struct Locations: Decodable {
    let standalone_locations: [Location]
}

struct Location: Decodable {
    let name: String
    let id: String
}
