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
    @State var AgeAndGender = false
    @Binding var Sex: Bool
    @Binding var age: Int
    @State var schedulingSheet = false
    var body: some View {
        VStack {
            Button{
                GoalSheet.toggle()
            } label: {
                Label("Goal Setting", systemImage: "target")
                
            }
            .fullScreenCover(isPresented: $GoalSheet){
                Goal_Page(info: $info, Sex: $Sex)
                
            }
            
            Button {
                AgeAndGender.toggle()
            } label: {
                Text("Age and Gender")
                
            }
            .fullScreenCover(isPresented: $AgeAndGender, content: {
                Age_Gender(info: $info)
            })
            Button {
                schedulingSheet.toggle()
            } label: {
                Text("Scheduling")
                
            }
            .fullScreenCover(isPresented: $schedulingSheet, content: {
                Scheduling_(info: $info, selectedDays: .constant([]), selectedTimes: .constant([]))
            })
        }   }
}


#Preview {
    Settings(info: .constant(data(Age: 0, Gender: false, prev: [], target: [], schedule: [], NAPHA_Date: Date.now, Goals: [])), selectedTimedSettings: .constant([]), selectedDaysSettings: .constant([]), Sex: .constant(true), age: .constant(0))
}
