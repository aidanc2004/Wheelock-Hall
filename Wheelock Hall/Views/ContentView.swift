//
//  ContentView.swift
//  Wheelock Hall
//
//  Created by Aidan Carey on 2023-07-18.
//

import SwiftUI

struct ContentView: View {
    @State private var success: Bool = true
    @State private var done: Bool = false
    @State private var first: Bool = false
    @State private var selected: String?
    static var currentPeriod: String = ""
    
    var body: some View {
        VStack {
            // if the api call was successful
            if success {
                NavigationView {
                    VStack {
                        // keep title while loading (after first load)
                        if done || first {
                            TitleView(periods: ApiCall.periods!,
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
                            MenuView(categories: ApiCall.categories!, selected: $selected)
                        } else {
                            if !first { Spacer() }
                            ProgressView()
                            Spacer()
                        }
                    }
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
            if api == nil {
                success.toggle()
                return
            } else {
                self.done = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
