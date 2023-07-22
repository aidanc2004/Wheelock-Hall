//
//  MenuView.swift
//  Wheelock Hall
//
//  Created by Aidan Carey on 2023-07-22.
//

import SwiftUI

struct MenuView: View {
    var categories: [Category]
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Wheelock Hall Menu")
                        .font(.title)
                    
                    Text(Date().formatted(date: .abbreviated, time: .omitted))
                        .foregroundColor(.gray)
                }
                .padding()
                .background()
                
                List {
                    ForEach(categories) { category in
                        CategoryView(category: category)
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
