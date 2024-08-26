//
//  Settings.swift
//  Napha Training App
//
//  Created by Kui Jun on 4/7/24.
//

import SwiftUI

struct Settings: View {
    
    @Binding var info: data
    @Binding var GoalSheet : Bool
    @Binding var AgeSheet   :Bool
    @Binding var SchedSheet : Bool
    @Binding var selectedTimedSettings: [Date]
    @Binding var selectedDaysSettings: [Int]
    @Binding var Sex: Bool
    @Binding var age: Int
    @Binding var ftSettings: Bool
    @State var GoalSheetSettings: Bool = false
    @State var AgeSheetSettings: Bool = false
    @State var SchedSheetSettings: Bool = false

    
    var body: some View {
        NavigationView {
            VStack(alignment:.leading) {
                HStack {
                    Text("General")
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                }
                .padding()
                .background(Color.white)
                
                Divider()
                
                Button(action: {
                    GoalSheetSettings.toggle()
                }) {
                    HStack {
                        Image(systemName: "target")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                        Text("Goal Setting")
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                }
                .fullScreenCover(isPresented: $GoalSheetSettings) {
                    Goal_Page(info: $info, Sex: $Sex, Age: $age, GoalSheet: $GoalSheet)
                }
                Button(action: {
                    AgeSheetSettings.toggle()
                })  {
                    HStack {
                        Image(systemName: "person")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                        Text("Age and Gender")
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                }
                .fullScreenCover(isPresented: $AgeSheetSettings){
                    Age_Gender(info: $info, ageFirstTime: $ftSettings, ageSheet: $AgeSheet)
                }
                
                Button(action: {
                    SchedSheet.toggle()
                }) {
                    HStack {
                        Image(systemName: "clock")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                        Text("Scheduling")
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                }
                .fullScreenCover(isPresented: $SchedSheet){
                    Scheduling_(info: $info, selectedDays: $selectedDaysSettings, selectedTimes: $selectedTimedSettings, schedSheet: $SchedSheet)
                }
            }
            .padding(.horizontal)
            .navigationBarHidden(true)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(info:.constant(data(Age: 0, Gender: false, prev: [], targ: [], schedule: [], NAPHA_Date: Date.now, Goals: [])), GoalSheet:.constant(false), AgeSheet:.constant(false), SchedSheet:.constant(false), selectedTimedSettings:.constant([]), selectedDaysSettings: .constant([]), Sex: .constant(true), age: .constant(0), ftSettings: .constant(true))
    }
}
