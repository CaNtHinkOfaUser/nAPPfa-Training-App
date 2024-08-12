//
//  Workout.swift
//  Napha Training App
//
//  Created by Kui Jun on 1/8/24.
//

import SwiftUI

struct Workout: View {
    
    @State var hi = ["jo", "no"]
    
    @Binding var info: data
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var exercise = ["",[0],0]
    @State var exerciseSet = [["",[0],0],["",[0],0],0]
    @State var exerciseNum = -1
    @State var rest = -10
    @State var done = false
    @State var totalTime = 0
    @State var breakAlert = false
    @State var weeksRange = [0,0]
    //Crunches, Leg Lifts, Seated Knee-ups, Sit-ups, Reverse Crunches, Leg Lifts with Hip Raises, U-Crunches
    @State var weeksSinceDownload = 0 - Int((UserDefaults.standard.object(forKey: "DOWNlOADEDDATE") as? Date)!.timeIntervalSinceNow / 604800) + 1
    
    
    //pull combinded components
    //days since downloaded
    
    @State var SitupsP = 0
    @State var SitupsT = 0
    @State private var Situps = [
        1:[["Crunches", 10, 1], ["Leg Lifts", 10, 1], ["Seated Knee-ups", 10, 1], ["Sit-ups", "Maximum", 1], 90],
        2:[["Crunches", 12, 1], ["Reverse Crunches", 12, 1], ["Seated Knee-up", 12, 1], ["Sit-ups", "Maximum", 1], 90],
        3:[["U-Crunches", 15, 1], ["Leg Lifts", 15, 1], ["Leg Lifts with Hip Raises", 15, 1], ["Sit-ups", "Maximum", 1], 90],
        4:[["Crunches", 15, 2], ["Seated Knee-ups", 15, 1], ["Leg Lifts", 15, 1], ["Sit-ups", "Maximum", 1], 90],
        5:[["Crunches", 10, 1], ["Seated Knee-ups", 10, 1], ["Leg Lifts", 10, 1], ["Sit-ups", "Maximum", 1], 60],
        6:[["Reverse Crunches", 10,5, 2], ["Leg Lifts with Hip Raises", 10,5, 2], ["U-Crunches", 10,5, 2], ["Sit-ups", "Maximum", 1], 180],
        7:[["Crunches", 10, 2], ["Reverse Crunchs", 10, 2], ["Leg Lifts", 10, 2], ["Sit-ups", "Maximum", 1], 180],
        8:[["Seated Knee-ups", 10, 2], ["U-Crunches", 10, 2], ["Crunches", 10, 2], ["Leg Lifts", 10, 2], ["Sit-ups", "Maximum", 1], 180],
        9:[["Reverse Crunches", 15, 2], ["Leg Lifts with Hip Raises", 15, 2], ["Crunches", 15, 2], ["Sit-ups", "Maximum", 1], 180],
        10:[["Seated Knee-ups", 15, 2], ["U-Crunches", 15, 2], ["Leg Lifts", 15, 2], ["Crunches", 15, 2], ["Sit-ups", "Maximum", 1], 180],
        11:[["Crunches", 20,15, 2], ["Reverse Crunches", 20,15, 2], ["U-Crunches", 20,15, 2], ["Sit-ups", "Maximum", 1], 180],
        12:[["Crunches", 15, 2], ["Seated Knee-ups", 15, 1], ["Leg Lifts", 15, 2], ["Sit-ups", "Maximum", 1], 180]
    ]
    
    var body: some View {
        VStack{
            Text(done ? "RESULTS":"WORKOUT")
                .fontWeight(.heavy)
                .font(.system(size: 50))
                .position(CGPoint(x: 200, y: 30))
            if !done{
                VStack{
                    if(rest == -10){
                        ZStack{
                            RoundedRectangle(cornerRadius: 50)
                                .foregroundStyle(.blue)
                                .frame(width: 300, height: 400)
                            Image("\(exercise[0])")
                                .resizable()
                                .frame(width: 300, height: 300)
                                .offset(y: 100)
                            Text("\(exercise[0] as! String == "Leg Lifts with Hip Raises" ? "Leg Lifts with\nHip Raises":exercise[0])")
                                .fontWeight(.semibold)
                                .font(.system(size: exercise[0] as! String == "Seated Knee-ups" ? 35: exercise[0] as! String == "Leg Lifts with Hip Raises" ? 30:50))
                                .offset(y: exercise[0] as! String == "Reverse Crunches" ? -120:-135)
                            Text("Reps: \(exercise[1]), Sets: \(exercise.last as! Int)")
                                .fontWeight(.semibold)
                                .font(.system(size: 25))
                                .offset(y: -50)
                        }
                        
                        HStack(spacing: 30){
                            Button{
                                rest = exerciseSet.last as! Int
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
                            .onAppear{
                                exerciseNum += 1
                                if(exerciseNum <= 3){
                                    exercise = (exerciseSet[exerciseNum]) as! [Any]
                                }
                                else{
                                    done = true
                                }
                            }
                            
                            Button{
                                breakAlert = true
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
                            .alert(isPresented: $breakAlert){
                                Alert(
                                    title: Text("Next"),
                                    message: Text("Are you sure you want to proceed without having a break?"),
                                    primaryButton: .destructive(Text("Yes")){
                                        exerciseNum += 1
                                        if(exerciseNum <= 3){
                                            exercise = (exerciseSet[exerciseNum]) as! [Any]
                                        }
                                        else{
                                            done = true
                                        }
                                    },
                                    secondaryButton: .cancel(Text("No"))
                                )
                            }
                        }
                    }
                    else{
                        Text("Break")
                            .fontWeight(.heavy)
                            .font(.system(size: 50))
                            .position(CGPoint(x: 200, y: -200))
                        Text("\(Int(rest / 60)):\(String(rest - Int(rest / 60)*60).count == 1 ? "0" : "")\(rest - Int(rest / 60)*60)")
                            .fontWeight(.bold)
                            .font(.system(size: 45))
                            .position(CGPoint(x: 200, y: -200))
                            .onReceive(timer){ _ in
                                if rest > 0{
                                    rest -= 1
                                }
                                if rest == 0{
                                    SoundManager.instance.playSound()
                                }
                            }
                        
                        HStack(spacing: 50){
                            Text("Remember to\nrehydrate\nyourself")
                                .font(.system(size: 25))
                                .offset(x: -30)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(5)
                            Image(systemName: "waterbottle")
                                .scaleEffect(6)
                        }
                        .offset(y: -100)
                        
                        Button{
                            rest = -10
                            exerciseNum += 1
                            if(exerciseNum <= 3){
                                exercise = (exerciseSet[exerciseNum]) as! [Any]
                            }
                            else{
                                done = true
                            }
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 25)
                                    .frame(width: 250,height: 100)
                                Text("End Break")
                                    .font(.system(size: 35))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                }
                .onAppear{
                    
                    //    diff 5: 1-12
                    //    diff 4: 1-12
                    //    diff 3: Below E: 1-9, D: 5-12
                    //    diff 2: Below E: 1-9, D: 5-12
                    //    diff 1: Below E: 1-5, D-C: 5-9, Above: 9-12
                    
                    SitupsP = info.prev[0] == "A" ? 5:(info.prev[0] == "B" ? 4:(info.prev[0] == "C" ? 3:(info.prev[0] == "D" ? 2:(info.prev[0] == "E" ? 1:0))))
                    SitupsT = info.targ[0] == "A" ? 5:(info.targ[0] == "B" ? 4:(info.targ[0] == "C" ? 3:(info.targ[0] == "D" ? 2:(info.targ[0] == "E" ? 1:0))))
                    
                    if ((SitupsT - SitupsP) >= 4){
                        weeksRange = [1,12]
                    }
                    else if ((SitupsT - SitupsP) >= 2){
                        if(SitupsP < 2){
                            weeksRange = [1,9]
                        }
                        else{
                            weeksRange = [5,12]
                        }
                    }
                    else if ((SitupsT - SitupsP) <= 1){
                        if (SitupsP <= 1){
                            weeksRange = [1,5]
                        }
                        else if (SitupsP <= 3){
                            weeksRange = [5,9]
                        }
                        else{
                            weeksRange = [9,12]
                        }
                    }
                    print(weeksRange)
                    exerciseSet = (Situps[weeksRange[0] + weeksSinceDownload - 1]) ?? [[[]]]
                }
            }
            else{
                VStack{
                    Text("You worked out for")
                        .fontWeight(.semibold)
                        .font(.system(size: 35))
                    Text("\(Int(totalTime / 60)):\(String(totalTime - Int(totalTime / 60)*60).count == 1 ? "0" : "")\(totalTime - Int(totalTime / 60)*60)")
                        .fontWeight(.heavy)
                        .font(.system(size: 50))
                    Text("on")
                        .fontWeight(.semibold)
                        .font(.system(size: 35))
                    Text("\(Date.now.formatted(date: .abbreviated, time: .omitted))")
                        .fontWeight(.heavy)
                        .font(.system(size: 50))
                    
                    HStack(spacing: 20){
                        //ERRORR
                        
//                        ForEach(0..<exerciseSet.count - 1, id: \.self){ i in
//                            Image("\((exerciseSet[i + 1] ?? [""])[0])")
//                                .resizable()
//                                .frame(width: 70,height: 70)
//                            Text("hi")
//                                .onAppear{
//                                    print((exerciseSet[i + 1] ?? [""])[0])
//                                    print(exerciseSet)
//                                }
//                        }
                    }
                }
                .offset(y: -200)
            }
        }
        .onReceive(timer){ _ in
            if(!done){
                totalTime += 1
            }
        }
    }
}

#Preview {
    Workout(info: .constant(data(Age: 0, Gender: false, prev: ["B","","","","",""], targ: ["A","","","","",""], schedule: [], NAPHA_Date: Date.now, Goals: [])))
}

