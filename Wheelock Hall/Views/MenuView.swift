//
//  MenuView.swift
//  Wheelock Hall
//
//  Created by Aidan Carey on 2023-07-22.
//

import SwiftUI

struct MenuView: View {
    var categories: [Category]
    @State var selected: String? = nil
    static var currentPeriod: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // menu
                List {
                    ForEach(categories) { category in
                        CategoryView(category: category, selected: $selected)
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
    }
}

// cant show preview because id need to make a new example category list
//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView()
//    }
//}
