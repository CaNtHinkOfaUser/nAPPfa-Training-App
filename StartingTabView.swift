//
//  StartingTabView.swift
//  Napha Training App
//
//  Created by Ishaan on 19/8/24.
//

import SwiftUI

struct StartingTabView: View {
    @Binding var StartingTabViewSheet: Bool
    @State private var selection: Int = 0
    @Binding var info: data
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                
                Age_Gender(info: .constant(data(Age: 0, Gender: false, prev: [], targ: [], schedule: [], NAPHA_Date: Date.now, Goals: [])), ageFirstTime: .constant(false), ageSheet: .constant(false))
                    .tag(0)
                Goal_Page(info: .constant(data(Age: 0, Gender: false, prev: [], targ: [], schedule: [], NAPHA_Date: Date.now, Goals: [])), Sex: .constant(false), Age: .constant(0), GoalSheet: .constant(false))
                    .tag(1)
                Scheduling_(info: .constant(data(Age: 0, Gender: false, prev: [], targ: [], schedule: [], NAPHA_Date: Date.now, Goals: [])), selectedDays: .constant([0]), selectedTimes: .constant([]))
                    .tag(2)
            }
            .tabViewStyle((.page(indexDisplayMode: .always)))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
           
            
        }
    }
/*    func goNext() {
        if selection < 2 {
            withAnimation {
                selection += 1
            }
            } else {
                StartingTabViewSheet = false
        }
} */
}
#Preview {
    StartingTabView(StartingTabViewSheet: .constant(false), info: .constant(data(Age: 0, Gender: false, prev: [], targ: [], schedule: [], NAPHA_Date: Date.now, Goals: [])))
}
