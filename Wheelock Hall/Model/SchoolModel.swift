//
//  SchoolModel.swift
//  Wheelock Hall
//
//  Created by Aidan Carey on 2023-07-30.
//

import Foundation

struct Schools: Decodable {
    let sites: [Site]
}

struct Site: Decodable {
    let id: String
    let name: String
    let slug: String // search by this
}
