//
//  Workout.swift
//  Napha Training App
//
//  Created by Kui Jun on 1/8/24.
//

import SwiftUI

struct Workout: View {
    
    @Binding var info: data
    @State var timeRemaining = 5
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var execise = "Sit-ups"
    
    @State private var programme = [
        [["Crunches", 10, 1], ["Leg Lifts", 10, 1], ["Seated Knee-up", 10, 1], ["Sit-ups", "Maximum", 1], 90],
        [["Crunches", 12, 1], ["Reverse Crunchs", 12, 1], ["Seated Knee-up", 12, 1], ["Sit-ups", "Maximum", 1], 90],
        [["U-Crunches", 15, 1], ["Leg Lifts", 15, 1], ["Leg Lifts with Hip Raises", 15, 1], ["Sit-ups", "Maximum", 1], 90],
        [["Crunches", 15, 2], ["Seated Knee-ups", 15, 1], ["Leg Lifts", 15, 1], ["Sit-ups", "Maximum", 1], 90],
        [["Crunches", 10, 1], ["Seated Knee-ups", 10, 1], ["Leg Lifts", 10, 1], ["Sit-ups", "Maximum", 1], 90],
        [["Reverse Crunches", 10, 1], ["Leg Lift with Hip Raises", 10, 1], ["U-Crunches", 10, 1], ["Sit ups", "Maximum", 1], 180],
        [["Crunches", 10, 2], ["Reverse Crunchs", 10, 2], ["Leg Lifts", 10, 2], ["Sit ups", "Maximum", 1], 180],

    ]
    
    var body: some View {
        Text("WORKOUT")
            .fontWeight(.heavy)
            .font(.system(size: 50))
            .position(CGPoint(x: 200, y: 30))
        Text("\(Int(timeRemaining / 60)):\(String(timeRemaining - Int(timeRemaining / 60)*60).count == 1 ? "0" : "")\(timeRemaining - Int(timeRemaining / 60)*60)")
            .fontWeight(.heavy)
            .font(.system(size: 50))
            .position(CGPoint(x: 200, y: -100))
            .onReceive(timer){ _ in
                if timeRemaining > 0{
                    timeRemaining -= 1
                }
                else{
                    SoundManager.instance.playSound()
                }
            }
        
        ZStack{
            RoundedRectangle(cornerRadius: 50)
                .foregroundStyle(.blue)
                .frame(width: 300, height: 200)
            Image("\(execise)")
            Text("\(execise)")
        }
        
        HStack(spacing: 50){
            Button{
                
            } label: {
                ZStack{
                    Circle()
                        .foregroundStyle(.yellow)
                        .frame(width: 130,height: 130)
                    Text("Break")
                        .font(.system(size: 30))
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                }
            }
            Button{
                
            } label: {
                ZStack{
                    Circle()
                        .foregroundStyle(.green)
                        .frame(width: 130,height: 130)
                    Text("Next")
                        .font(.system(size: 30))
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                }
            }
        }
        .offset(y: 0)
    }
}

#Preview {
    Workout(info: .constant(data(Age: 0, Gender: false, prev: [], target: [], schedule: [], NAPHA_Date: Date.now, Goals: [])))
}
