//
//  TitleView.swift
//  Wheelock Hall
//
//  Created by Aidan Carey on 2023-07-26.
//

import SwiftUI

struct TitleView: View {
    var periods: [Period]
    var callApi: (Int) -> ()
    
    @Binding var done: Bool
    
    static var currentPeriod: String = ""
    
    var body: some View {
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
                
                Menu(Self.currentPeriod == "" ? periods[0].name : Self.currentPeriod) {
                    ForEach(periods, id: \.sort_order) { period in
                        Button(period.name) {
                            done = false
                            callApi(period.sort_order)
                            Self.currentPeriod = period.name
                        }
                    }
                }
                .font(.title3)
                .padding(.horizontal)
            }
        }
    }
}

//struct TitleView_Previews: PreviewProvider {
//    static var previews: some View {
//        TitleView()
//    }
//}
