//
//  MenuView.swift
//  Wheelock Hall
//
//  Created by Aidan Carey on 2023-07-22.
//

import SwiftUI

struct MenuView: View {
    var categories: [Category]
    @Binding var selected: String?
    
    var body: some View {
        VStack {
            // menu
            List {
                ForEach(categories) { category in
                    CategoryView(category: category, selected: $selected)
                }
            }
            // TODO: .insetGrouped doesnt work on mac
            .listStyle(.inset)
        }
    }
}

// cant show preview because id need to make a new example category list
//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView()
//    }
//}
