//
//  Settings.swift
//  Napha Training App
//
//  Created by Kui Jun on 4/7/24.
//

import SwiftUI

struct Settings: View {
    
    @Binding var info: data
    @State var GoalSheet = false
    @Binding var selectedTimedSettings: [Date]
    @Binding var selectedDaysSettings: [Int]
    var body: some View {
        Button{
            GoalSheet.toggle()
        } label: {
            Label("Goal Setting", systemImage: "target")
        }
        .sheet(isPresented: $GoalSheet){
            Goal_Page(info: $info, selectedDays: $selectedDaysSettings, selectedTimes: $selectedTimedSettings)
            
        }
    }
}

#Preview {
    Settings(info: .constant(data(Age: 0, Gender: false, prev: [], target: [], schedule: [], NAPHA_Date: Date.now, Goals: [])), selectedTimedSettings: .constant([]), selectedDaysSettings: .constant([]))
}
