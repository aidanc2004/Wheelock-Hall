//
//  ContentView.swift
//  Wheelock Hall
//
//  Created by Aidan Carey on 2023-07-18.
//

import SwiftUI

struct ContentView: View {
    @State var categories: [Category] = []
    
    var body: some View {
        List {
            ForEach(categories) { category in
                Section(header: Text(category.name).font(.title)) {
                    ForEach(category.items) { item in
                        Text(item.name)
                            .font(.subheadline)
                    }
                }
            }
        }
        .onAppear {
            apiCall().getApi { api in
                self.categories = api.menu.periods.categories
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
