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
    @Binding var Sex: Bool
    @Binding var age: Int
  
    
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
                    GoalSheet.toggle()
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
                .fullScreenCover(isPresented: $GoalSheet) {
                    Goal_Page(info: $info, Sex: $Sex, showAlert: .constant(false))
                }
                NavigationLink {
                    Age_Gender(info: $info)
                } label: {
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
                
                NavigationLink {
                    Scheduling_(info: $info, selectedDays: $selectedDaysSettings, selectedTimes: $selectedTimedSettings)
                } label: {
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
            }
            .padding(.horizontal)
            .navigationBarHidden(true)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(info:.constant(data(Age: 0, Gender: false, prev: [], target: [], schedule: [], NAPHA_Date: Date.now, Goals: [])), selectedTimedSettings:.constant([]), selectedDaysSettings:.constant([]), Sex:.constant(true), age:.constant(0))
    }
}
