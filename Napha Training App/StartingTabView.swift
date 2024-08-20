//
//  StartingTabView.swift
//  Napha Training App
//
//  Created by Ishaan on 19/8/24.
//

import SwiftUI

struct StartingTabView: View {
   // @Binding var StartingTabViewSheet: Bool
    @State private var selection: Int = 0
    @Binding var info: data
    @Binding var ageFirstTime: Bool
    @Binding var ageSheet: Bool
    @Binding var Sex: Bool
    @Binding var Age: Int
    @Binding var goalSheet: Bool
    @Binding var selectedDays: [Int]
    @Binding var selectedTimes: [Date]
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                
                Age_Gender(info: $info, ageFirstTime: $ageFirstTime, ageSheet: $ageSheet)
                    .tag(0)
                Goal_Page(info: $info, Sex: $Sex, Age: $Age, GoalSheet: $goalSheet)
                    .tag(1)
                Scheduling_(info: $info, selectedDays: $selectedDays, selectedTimes: $selectedTimes)
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
    StartingTabView(info: .constant(data(Age: 0, Gender: false, prev: [], targ: [], schedule: [], NAPHA_Date: Date.now, Goals: [])), ageFirstTime: .constant(false), ageSheet: .constant(false), Sex: .constant(false), Age: .constant(0), goalSheet: .constant(false), selectedDays: .constant([0]), selectedTimes: .constant([]))
}
