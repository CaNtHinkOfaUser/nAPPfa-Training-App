//  Home.swift
//  Napha Training App
//
//  Created by Kui Jun on 24/6/24.
//

import SwiftUI
import UserNotifications


struct Home: View {
   
    @Binding var info: data
    @State var prevWorkout = UserDefaults.standard.string(forKey: "prevWorkout") ?? ""
    @State var combined: Date = Date()
    @State private var exercises = ["Sit Ups", "Standing Broad Jump", "Sit & Reach", "Inclined Pull Ups", "Shuttle Run", "2.4km Run"]
    @State var sent_before = false
    @State private var Goalindx = 0
    @Binding var homeSelectedTimed: [Date]
    @State var DayIndex = Calendar.current.component(.weekday, from: Date())
    @Binding var homeSelectedDays: [Int]
    @State var timeUntilNextWorkout: DateComponents = Calendar.current.dateComponents([.hour], from: Date())
    @State var daySelected: Bool = false
    @State var selectedDayComponent = Date()
    @State var datesButToday: [Date] = []
    @State var resultFromFunction: Int = 0
    @State var nextWorkoutComponents = Calendar.current.dateComponents([.hour, .minute], from: Date())
    @State var notificationAuthorized: Bool = false
    var todayComponents: DateComponents {
        Calendar.current.dateComponents([.year, .month, .day], from: Date())
    }
    @State var combinedComponents = DateComponents()
    var adjustedDates: [Date] {
        let calendar = Calendar.current
        let todayComponents = self.todayComponents
        
        return homeSelectedTimed.map { date in
            
            
            var newComponents = DateComponents()
            newComponents.year = todayComponents.year
            newComponents.month = todayComponents.month
            newComponents.day = todayComponents.day
            
            return calendar.date(from: newComponents) ?? date
        }
    }

    
    @State var dayNum: Int = (Calendar.current.component(.weekday, from: Date())+5) % 7 + 1
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium // Choose a date style (e.g., .short, .medium, .long)
        formatter.timeStyle = .short // Choose a time style (e.g., .none, .short, .medium, .long)
        return formatter
    }()
    @State var zippedTimeDay: [(Int,Date)] = []
    @State var sortedDays: [Int] = []
    @State var sortedTimes: [Date] = []
    @State var nextWorkout: Date = Date()
    
    var body: some View {
        NavigationStack{
            VStack{
                /* ForEach(sortedTimes, id: \.self){ i in
                 Text(dateFormatter.string(from: i))
                 //used for testing, remove later
                 }
                 ForEach(sortedDays, id: \.self){i in
                 Text((String(i+1)))
                 
                 }*/
                
                







                Text("NAPFA EXAMINATION IN")
                    .font(.system(size: 20))
                    .bold()
                Text("\(info.NAPHA_Date.formatted(date: .long, time: .omitted))")
                    .font(.system(size: 45))
                    .bold()
                    .contextMenu{
                        Text("\(Calendar.current.dateComponents([.month,.day], from: Date.now, to: info.NAPHA_Date).month ?? 0) months : \(Calendar.current.dateComponents([.month,.day], from: Date.now, to: info.NAPHA_Date).day ?? 0) days")
                    }
                Text("Note: This is an MVP")
                Grid{
                    GridRow{
                        ZStack{
                            RoundedRectangle(cornerRadius: 25.0)
                                .frame(width: 150,height: 200)
                                .foregroundColor(.yellow)
                            if(prevWorkout == ""){
                                Text("\(prevWorkout == "" ? "You havent worked out yet" : prevWorkout)")
                                    .padding()
                            }
                            else{
                                Image("\(prevWorkout)")
                            }
                        }
                        .gridColumnAlignment(.trailing)
                        .offset(x: 60)
                        
                        ZStack{
                            Image("Calendar")
                                .scaledToFit()
                                .scaleEffect(0.55)
                            Text(/*timeUntilNextWorkout.hour! >= 24 ?
                                  String(Int(ceil(Double(timeUntilNextWorkout.hour!/24)))+1) :*/ timeUntilNextWorkout.hour! > 0 ? String(timeUntilNextWorkout.hour!+1) : String(0))
                            .font(.system(size: 60))
                            .bold()
                            .contextMenu(ContextMenu(menuItems: {
                                Text(dateFormatter.string(from: combined))
                            }))
                        }
                        .gridColumnAlignment(.leading)
                    }
                }
                
                Button{
                    if info.Goals != []{
                        if (Goalindx == info.Goals.count - 1){
                            Goalindx = 0
                        }
                        else{
                            Goalindx += 1
                        }
                    }
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 40)
                            .fill(.blue)
                            .padding(.horizontal, 30)
                            .offset(y: 56)
                        
                        Text(info.Goals == [] ? "You dont have any goals yet.\nGo to Settings > Goal Page\nto set some!" :"I will get\n\(info.Goals[Goalindx][0])\nfor \(info.Goals[Goalindx][1])")
                            .font(.system(size: info.Goals == [] ? 20 : 20))
                            .foregroundStyle(.white)
                            .offset(y: 50)
                    }
                }
                .offset(y: -150)
                
            }
        }
        .onAppear{
            if let storedDate = UserDefaults.standard.object(forKey: "nextWorkout") as? Date {
                nextWorkout = storedDate
            }
            print(nextWorkout)

            
            

           
            
            /*daySelected = false
             for i in homeSelectedDays{
             if daySelected == false {
             if Int(Calendar.current.weekdaySymbols[DayIndex]) == Int(i) {
             selectedDayComponent =  homeSelectedTimed[homeSelectedDays.firstIndex(of: Int(i))!]
             
             }
             }*/
            
            zippedTimeDay = zip(homeSelectedDays,homeSelectedTimed).sorted{ $0.0 < $1.0}
            sortedDays = zippedTimeDay.map { $0.0 }
            sortedTimes = zippedTimeDay.map { $0.1 }
            dayNum = (Calendar.current.component(.weekday, from: Date())+5) % 7 + 1
            print("zipeed: \(zippedTimeDay)")
            if sortedTimes.isEmpty == false {
                if sortedDays.contains(dayNum) {
                    
                    
                
                    if sortedTimes[sortedDays.firstIndex(of: dayNum)!] > Date() {
                        resultFromFunction = sortedDays.firstIndex(of: dayNum)!
                    } else {
                        resultFromFunction = sortedDays.firstIndex(of: dayNum)!
                    }
                    
                } else {
                    var newSortedDays: [Int] = sortedDays.map { $0 }
                    newSortedDays.append(dayNum)
                    newSortedDays.sort()
                    if newSortedDays.last == dayNum {
                        resultFromFunction = 0
                        
                    } else {
                        resultFromFunction = newSortedDays.firstIndex(of: dayNum)!
                    }
                }
            }
            if sortedTimes.isEmpty == false {
                nextWorkout = sortedTimes[resultFromFunction]
                 nextWorkoutComponents = Calendar.current.dateComponents([.hour, .minute], from: nextWorkout)
                
                let todayComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
                let comparingComponents = Calendar.current.dateComponents([.hour, .minute, .year, .month, .day], from: Date())
                
                combinedComponents = DateComponents()
                combinedComponents.hour = nextWorkoutComponents.hour
                combinedComponents.minute = nextWorkoutComponents.minute
                combinedComponents.day = todayComponents.day
                let dayOffset = sortedDays[resultFromFunction] + 1 - dayNum
                combinedComponents.day = todayComponents.day! + dayOffset
                combinedComponents.day! = todayComponents.day! + dayOffset
                
                combinedComponents.month = todayComponents.month
                combinedComponents.year = todayComponents.year
                combined = Calendar.current.date(from: combinedComponents)!
                
                if (Date()>combined){
                    nextWorkoutComponents.year = todayComponents.year
                    nextWorkoutComponents.month = todayComponents.month
                    nextWorkoutComponents.day = todayComponents.day! + sortedDays[resultFromFunction]+8 - dayNum
                    combinedComponents.day = todayComponents.day! + sortedDays[resultFromFunction]+8 - dayNum
                    combined = Calendar.current.date(from: combinedComponents)!
                    nextWorkout = Calendar.current.date(from: nextWorkoutComponents)!
                } else {
                    
                    
                    nextWorkoutComponents.year = todayComponents.year
                    nextWorkoutComponents.month = todayComponents.month
                    nextWorkoutComponents.day = todayComponents.day! + sortedDays[resultFromFunction]+1 - dayNum
                    nextWorkout = Calendar.current.date(from: nextWorkoutComponents)!
                    
                }
                
                print("selected Days: \(homeSelectedDays)")
            }
            timeUntilNextWorkout = Calendar.current.dateComponents([.hour], from: Date(), to: nextWorkout)
            print("nextWorkout \(nextWorkout)")
                UserDefaults.standard.setValue(nextWorkout, forKey: "nextWorkout")
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if granted {
                        let content = UNMutableNotificationContent()
                        content.title = "Time for your workout"
                        content.subtitle = "Exercise now!"
                        content.sound = UNNotificationSound.default
                        
                        let trigger = UNCalendarNotificationTrigger(dateMatching: nextWorkoutComponents, repeats: true)
                        
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        

                            UNUserNotificationCenter.current().add(request)
                            
                        print("notification sent")
                    } else {
                        print("Notification authorization denied")
                    }
                }
            }
        }
}



#Preview {
    Home(info: .constant(data(Age: 0, Gender: false, prev: [], targ: [], schedule: [], NAPHA_Date: Date.now, Goals: [])), homeSelectedTimed: .constant([]), homeSelectedDays: .constant([]))
}
