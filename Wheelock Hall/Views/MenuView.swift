//
//  MenuView.swift
//  Wheelock Hall
//
//  Created by Aidan Carey on 2023-07-22.
//

import SwiftUI

struct MenuView: View {
    var categories: [Category]
    var periods: [Period]
    var callApi: (Int) -> ()
    @State var selected: String? = nil
    
    // TODO: initalize this to periods[0].name
    @State private var currentPeriod: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // header
                VStack {
                    // name and date
                    VStack {
                        Text("Wheelock Hall Menu")
                            .font(.title)
                        
                        Text(Date().formatted(date: .abbreviated, time: .omitted))
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical)
                    
                    // menu selection
                    HStack {
                        Spacer()
                        
                        // TODO: add loading circle when switching periods
                        Menu(currentPeriod == "" ? periods[0].name : currentPeriod) {
                            ForEach(periods, id: \.sort_order) { period in
                                Button(period.name) {
                                    callApi(period.sort_order)
                                    currentPeriod = period.name
                                }
                            }
                        }
                        .font(.title3)
                        .padding(.horizontal)
                    }
                }
                
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
