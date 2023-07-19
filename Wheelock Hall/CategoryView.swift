//
//  CategoryView.swift
//  Wheelock Hall
//
//  Created by Aidan Carey on 2023-07-19.
//

import SwiftUI

struct CategoryView: View {
    var category: Category
    
    var body: some View {
        Section(header: Text(category.name).font(.title)) {
            ForEach(category.items) { item in
                Text(item.name)
                    .font(.subheadline)
            }
        }
    }
}

// cannot show preview because it requires a category with items
//struct CategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryView()
//    }
//}
