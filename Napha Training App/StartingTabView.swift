//
//  StartingTabView.swift
//  Napha Training App
//
//  Created by Ishaan on 19/8/24.
//

import SwiftUI

struct StartingTabView: View {
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
            ZStack {
                GeometryReader { geometry in
                    
                    // Progress indicator with animated capsule
                    HStack {
                        Text("Step \(selection + 1) of 4")
                        
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 200, height: 10)
                            
                            Capsule()
                                .fill(Color.green)
                                .frame(width: CGFloat(selection + 1) * 50, height: 10) // Adjust width dynamically based on selection
                                .animation(.easeInOut(duration: 0.3), value: selection) // Smooth animation
                        }
                        .offset(x: 10)
                    }
                    .offset(x: 80, y: 66)
                }.padding(.vertical, -100)
            
                TabView(selection: $selection) {
                    Age_Gender(start: .constant(true), info: $info, ageFirstTime: $ageFirstTime, ageSheet: $ageSheet)
                        .tag(0)
                    
                    Goal_Page(start: .constant(true), info: $info, Sex: $Sex, Age: $Age, GoalSheet: $goalSheet)
                        .tag(1)
                    
                    Scheduling_(start: .constant(true), info: $info, selectedDays: $selectedDays, selectedTimes: $selectedTimes, schedSheet: $schedSheet)
                        .tag(2)
                    
                    VStack {
                        Button {
                            showLogin = false
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10.0)
                                    .frame(width: 100, height: 50)
                                Text("Save")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30))
                            }
                        }
                    }
                    .tag(3)
                    .offset(y: -40)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}

#Preview {
    StartingTabView(info: .constant(data(Age: 0, Gender: false, prev: [], targ: [], schedule: [], NAPFA_Date: Date.now, Goals: [])),
                    ageFirstTime: .constant(false),
                    ageSheet: .constant(false),
                    Sex: .constant(false),
                    Age: .constant(0),
                    goalSheet: .constant(false),
                    selectedDays: .constant([0]),
                    selectedTimes: .constant([]),
                    schedSheet: .constant(false),
                    showLogin: .constant(true))
}
