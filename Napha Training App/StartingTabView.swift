//
//  StartingTabView.swift
//  Napha Training App
//
//  Created by Ishaan on 19/8/24.
//

import SwiftUI

struct StartingTabView: View {
   // @Binding var StartingTabViewSheet: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var selection: Int = 0
    @Binding var info: data
    @Binding var ageFirstTime: Bool
    @Binding var ageSheet: Bool
    @Binding var Sex: Bool
    @Binding var Age: Int
    @Binding var goalSheet: Bool
    @Binding var selectedDays: [Int]
    @Binding var selectedTimes: [Date]
    @Binding var schedSheet: Bool
    @Binding var showLogin: Bool
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                Age_Gender(start:.constant(true), info: $info, ageFirstTime: $ageFirstTime, ageSheet: $ageSheet)
                    .tag(0)
                Goal_Page(start: .constant(true), info: $info, Sex: $Sex, Age: $Age, GoalSheet: $goalSheet)
                    .tag(1)
                Scheduling_(start: .constant(true), info: $info, selectedDays: $selectedDays, selectedTimes: $selectedTimes, schedSheet: $schedSheet)
                    .tag(2)
                VStack{
                    Button{
                        showLogin = false                   
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 25.0)
                                .frame(width: 100,height: 100)
                            Text("Save")
                                .foregroundStyle(.white)
                                .font(.system(size: 30))
                        }
                    }
                }.tag(3)
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
    StartingTabView(info: .constant(data(Age: 0, Gender: false, prev: [], targ: [], schedule: [], NAPHA_Date: Date.now, Goals: [])), ageFirstTime: .constant(false), ageSheet: .constant(false), Sex: .constant(false), Age: .constant(0), goalSheet: .constant(false), selectedDays: .constant([0]), selectedTimes: .constant([]), schedSheet: .constant(false), showLogin: .constant(true))
}
