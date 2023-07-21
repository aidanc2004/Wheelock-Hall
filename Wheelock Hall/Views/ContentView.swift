//
//  ContentView.swift
//  Wheelock Hall
//
//  Created by Aidan Carey on 2023-07-18.
//

import SwiftUI

struct ContentView: View {
    @State var categories: [Category] = []
    @State var success: Bool = true
    
    var body: some View {
        VStack {
            // if the api call was successful
            if success {
                // if not done, show a loading symbol
                if !categories.isEmpty {
                    Text("Wheelock Hall Menu")
                        .font(.title)
                    
                    List {
                        ForEach(categories) { category in
                            CategoryView(category: category)
                        }
                    }
                    .listStyle(.insetGrouped)
                } else {
                    ProgressView()
                }
            // otherwise show error message
            } else {
                Label("Failed to get menu.", systemImage: "exclamationmark.triangle.fill")
                    .font(.title)
            }
        }
        .onAppear {
            ApiCall().getApi { api in
                guard let api else {
                    success.toggle()
                    return
                }
                
                self.categories = api.menu.periods.categories
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
