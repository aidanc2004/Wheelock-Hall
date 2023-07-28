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
    @State private var done: Bool = false
    @State private var first: Bool = false
    @State private var selected: String? = nil
    static var currentPeriod: String = ""
    
    var body: some View {
        VStack {
            // if the api call was successful
            if success {
                // keep title while loading (after first load)
                if done || first {
                    TitleView(periods: periods,
                              callApi: callApi,
                              done: $done,
                              selected: $selected)
                    .onAppear {
                        first = true
                    }
                    Spacer()
                }
                
                // if not done, show a loading symbol
                if done {
                    MenuView(categories: categories, selected: $selected)
                } else {
                    if !first { Spacer() }
                    ProgressView()
                    Spacer()
                }
            // otherwise show error message
            } else {
                VStack {
                    Label("Failed to get menu.", systemImage: "exclamationmark.triangle.fill")
                        .font(.title)
                    Text(ApiCall.error!)
                }
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
            
            self.done = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
