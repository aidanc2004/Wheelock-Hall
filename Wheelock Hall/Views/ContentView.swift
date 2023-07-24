//
//  ContentView.swift
//  Wheelock Hall
//
//  Created by Aidan Carey on 2023-07-18.
//

import SwiftUI

struct ContentView: View {
    @State private var categories: [Category] = []
    @State private var periods: [Period] = []
    @State private var success: Bool = true
    
    var body: some View {
        VStack {
            // if the api call was successful
            if success {
                // if not done, show a loading symbol
                if !categories.isEmpty {
                    MenuView(categories: categories,
                             periods: periods,
                             callApi: callApi)
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
            // default to first
            callApi(period: 0)
        }
    }
    
    func callApi(period: Int) {
        ApiCall().getApi(period: period) { api in
            guard let api else {
                success.toggle()
                return
            }
            
            self.categories = api.menu.periods.categories
            self.periods = api.periods
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
