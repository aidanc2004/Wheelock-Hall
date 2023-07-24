//
//  ContentView.swift
//  Wheelock Hall
//
//  Created by Aidan Carey on 2023-07-18.
//

/* TODO: add period selection so it only shows breakfast, lunch, etc */

import SwiftUI

struct ContentView: View {
    @State private var categories: [Category] = []
    @State private var periods: [Period] = []
    @State var success: Bool = true
    
    var body: some View {
        VStack {
            // if the api call was successful
            if success {
                // if not done, show a loading symbol
                if !categories.isEmpty {
                    MenuView(categories: categories, periods: periods)
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
                self.periods = api.periods
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
