//  Home.swift
//  Napha Training App
//
//  Created by Kui Jun on 24/6/24.
//

import SwiftUI
import UserNotifications


struct Home: View {
    
    @Binding var info: data
    @State private var exercises = ["Sit Ups", "Standing Broad Jump", "Sit & Reach", "Inclined Pull Ups", "Shuttle Run", "2.4km Run"]
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
                Text(dateFormatter.string(from: nextWorkout))
                Text(sortedDays.isEmpty ? "0" : String(sortedDays[resultFromFunction]))
                Text(String(dayNum))
                Text("Sorted Days: \(sortedDays.map { String($0) }.joined(separator: ", "))")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                Button("send notif"){
                    let content = UNMutableNotificationContent()
                    content.title = "Feed the cat"
                    content.subtitle = "It looks hungry"
                    content.sound = UNNotificationSound.default
                    
                    // show this notification five seconds from now
                    let trigger = UNCalendarNotificationTrigger(dateMatching: nextWorkoutComponents, repeats: true)
                    
                    // choose a random identifier
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    // add our notification request
                    UNUserNotificationCenter.current().add(request)
                }
                Text("NAPFA EXAMINATION IN")
                    .font(.system(size: 20))
                    .bold()
                Text("\(info.NAPHA_Date.formatted(date: .long, time: .omitted))")
                    .font(.system(size: 45))
                    .bold()
                    .contextMenu{
                        Text("\(Calendar.current.dateComponents([.month,.day], from: Date.now, to: info.NAPHA_Date).month ?? 0) months : \(Calendar.current.dateComponents([.month,.day], from: Date.now, to: info.NAPHA_Date).day ?? 0) days")
                    }
                Grid{
                    GridRow{
                        ZStack{
                            RoundedRectangle(cornerRadius: 25.0)
                                .frame(width: 150,height: 200)
                                .foregroundColor(.yellow)
                            Text("Placeholder")
                        }
                        .gridColumnAlignment(.trailing)
                        .offset(x: 60)
                        
                        ZStack{
                            Image("Calendar")
                                .scaledToFit()
                                .scaleEffect(0.55)
                            Text(timeUntilNextWorkout.hour! >= 24 ?
                                 String(Int(ceil(Double(timeUntilNextWorkout.hour!/24)))+1) : String(timeUntilNextWorkout.hour!) )
                            .font(.system(size: 60))
                            .bold()
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
                    print(Calendar.current.dateComponents([.month,.day], from: Date.now, to: info.NAPHA_Date))
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
            if !notificationAuthorized {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        notificationAuthorized = true
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
            
    
            let notificationIdentifier = "workoutNotification"
            
            
                            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])
            
                            // Create a new notification request with the fixed identifier
                            let content = UNMutableNotificationContent()
                            content.title = "Time for your workout!"
                            content.subtitle = "Exercise Now"
                            content.sound = UNNotificationSound.default
            
                          
            var nextWorkoutComponents = Calendar.current.dateComponents([.hour, .minute, .day, .month, .year], from: nextWorkout)
            let trigger = UNCalendarNotificationTrigger(dateMatching: nextWorkoutComponents, repeats: false)
            let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)

            
                            
                            UNUserNotificationCenter.current().add(request)
           
            
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
                print(sortedTimes)
                print(resultFromFunction)
                nextWorkout = sortedTimes[resultFromFunction]
                 nextWorkoutComponents = Calendar.current.dateComponents([.hour, .minute], from: nextWorkout)
                
                let todayComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
                let comparingComponents = Calendar.current.dateComponents([.hour, .minute, .year, .month, .day], from: Date())
                let comparingDate = Calendar.current.date(from: comparingComponents)
                var combinedComponents = DateComponents()
                combinedComponents.hour = nextWorkoutComponents.hour
                combinedComponents.minute = nextWorkoutComponents.minute
                combinedComponents.day = todayComponents.day
                let dayOffset = sortedDays[resultFromFunction] + 1 - dayNum
                                combinedComponents.day = todayComponents.day! + dayOffset
                combinedComponents.day! = todayComponents.day! + dayOffset
                
                combinedComponents.month = todayComponents.month
                combinedComponents.year = todayComponents.year
                let combined = Calendar.current.date(from: combinedComponents)!
                
                if (Date()>combined){
                    nextWorkoutComponents.year = todayComponents.year
                    nextWorkoutComponents.month = todayComponents.month
                    nextWorkoutComponents.day = todayComponents.day! + sortedDays[resultFromFunction]+8 - dayNum
                    nextWorkout = Calendar.current.date(from: nextWorkoutComponents)!
                } else {
                    
                    
                    nextWorkoutComponents.year = todayComponents.year
                    nextWorkoutComponents.month = todayComponents.month
                    nextWorkoutComponents.day = todayComponents.day! + sortedDays[resultFromFunction]+1 - dayNum
                    nextWorkout = Calendar.current.date(from: nextWorkoutComponents)!
                    
                }
                
            }
            timeUntilNextWorkout = Calendar.current.dateComponents([.hour], from: Date(), to: nextWorkout)
           
            }
        }
}



#Preview {
    Home(info: .constant(data(Age: 0, Gender: false, prev: [], target: [], schedule: [], NAPHA_Date: Date.now, Goals: [])), homeSelectedTimed: .constant([]), homeSelectedDays: .constant([]))
}
