import SwiftUI
import AVFoundation

class SoundManager {
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "Alarm", withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error playing sound")
        }
    }
}

struct data{
    var Age: Int
    var Gender: Bool
    var prev: [String]
    var targ: [String]
    var schedule: [String]
    var NAPHA_Date: Date
    var Goals: [[String]]
    
    init(Age: Int, Gender: Bool, prev: [String], targ: [String], schedule: [String], NAPHA_Date: Date, Goals: [[String]]) {
        self.Age = Age
        self.Gender = Gender
        self.prev = prev
        self.targ = targ
        self.schedule = schedule
        self.NAPHA_Date = NAPHA_Date
        self.Goals = Goals
        
        UITabBar.appearance().isHidden = true
    }
    
    //    init(from decoder:  Decoder) throws {
    //        let container = try decoder.container(keyedBy: CodingKeys.self)
    //        self.Age = try container.decode(Float.self, forKey: .Age)
    //        self.Gender = try container.decode(Bool.self, forKey: .Gender)
    //        self.prev = try container.decode(Array.self, forKey: .prev)
    //        self.target = try container.decode(Array.self, forKey: .target)
    //        self.schedule = try container.decode(Array.self, forKey: .schedule)
    //        self.NAPHA_Date = try container.decode(Date.self, forKey: .NAPHA_Date)
    //    }
}

struct ContentView: View {
    
    @State var info = data(Age: 12, Gender: false, prev: ["","","","","",""], targ: ["","","","","",""], schedule: [], NAPHA_Date: Date.now, Goals: [])
    @State var selectedTimesCV: [Date] = []
    @State var selectedDaysCV: [Int] = []
    @State var Sex: Bool = true
    @State var age: Int = 12
    @State var prevWorkout = ""
    @State var firstTime = true
    @State var GoalSheetCV = false
    @State var AgeSheetCV = false
    @State var SchedSheetCV = false
    @State var selectedTab: Tab = .house
    @State var Startingpage = false
    var body: some View {
        
        if selectedTab == .house {
            Home(info: $info, prevWorkout: $prevWorkout, homeSelectedTimed: $selectedTimesCV, homeSelectedDays: $selectedDaysCV)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .fullScreenCover(isPresented: $firstTime){
                    StartingPage(info: $info,ageFirstTime: $firstTime,ageSheet: $AgeSheetCV,Sex: $Sex,Age: $age,goalSheet: $GoalSheetCV,schedSheet: $SchedSheetCV, selectedDays: $selectedDaysCV,selectedTimes: $selectedTimesCV)
                }
                .onChange(of: SchedSheetCV){
                    if GoalSheetCV == false{
                        firstTime = false
                        UserDefaults.standard.setValue(false, forKey: "fT")
                        
                        print("firstTime is now false")
                    }
                 }
               
                
                /*.fullScreenCover(isPresented: $AgeSheetCV){
                    Age_Gender(info: $info, ageFirstTime: $firstTime, ageSheet: $AgeSheetCV)
                }
                .onChange(of: AgeSheetCV){
                    if AgeSheetCV == false{
                        SchedSheetCV = true
                        print("schedSheet CV is true")
                    }
                }
                .fullScreenCover(isPresented: $SchedSheetCV){
                    Scheduling_(info: $info, selectedDays: $selectedDaysCV, selectedTimes: $selectedTimesCV)
                }
                .onChange(of: SchedSheetCV){
                    if SchedSheetCV == false{
                        GoalSheetCV = true
                        print("GoalSheet CV is true")
                    }
                }
                .fullScreenCover(isPresented: $GoalSheetCV){
                    Goal_Page(info: $info, Sex: $Sex, Age: $age, GoalSheet: $GoalSheetCV)
                }
                .onChange(of: GoalSheetCV){
                    if GoalSheetCV == false{
                        firstTime = false
                        UserDefaults.standard.setValue(false, forKey: "fT")
                        
                        print("firstTime is now false")
                    }
                 } */
            
        } else if selectedTab == .dumbbell{
            Workout(prevWorkout: $prevWorkout, info: $info)
                .tabItem {
                    ZStack{
                        Circle()
                            .foregroundStyle(.blue)
                            .frame(width: 60,height: 60)
                        Image(systemName: "dumbbell.fill")
                            .scaleEffect(2)
                            .foregroundStyle(.white)
                        Text("Workout Now!")
                            .offset(y: 50)
                            .font(.system(size: 13))
                            .foregroundStyle(.black)
                    }
                }
        } else {
            Settings(info: $info, GoalSheet: $GoalSheetCV, AgeSheet: $AgeSheetCV, SchedSheet: $SchedSheetCV, selectedTimedSettings: $selectedTimesCV, selectedDaysSettings: $selectedDaysCV, Sex: $Sex, age: $age, ftSettings: $firstTime)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        VStack{
            CustomTabBar(selectedTab: $selectedTab)

        } /* .fullScreenCover(isPresented: $Startingpage){ "eg for full screen thing
            StartingPage(info: $info, TabViewSheet: false, showNewView: false, nextAction: {}) */
        .onAppear{
            if let storedFirst = UserDefaults.standard.object(forKey: "fT") as? Bool {
                firstTime = storedFirst
                
            }
            if firstTime == true {
                AgeSheetCV = true
            }
            
            
            if let storedSex = UserDefaults.standard.object(forKey: "sex") as? Bool {
                info.Gender = storedSex
                
            }
            if let storedAge = UserDefaults.standard.object(forKey: "age") as? Int{
                info.Age = storedAge
            }
            UserDefaults.standard.setValue(UserDefaults.standard.bool(forKey: "Downloaded?") ?? true, forKey: "Downloaded?")
            if(UserDefaults.standard.bool(forKey: "Downloaded?")){
                UserDefaults.standard.setValue(Date.now, forKey: "DOWNlOADEDDATE")
                UserDefaults.standard.setValue(false, forKey: "Downloaded?")
            }
            //print((UserDefaults.standard.object(forKey: "DOWNlOADEDDATE") as? Date)!.formatted(date: .abbreviated, time: .standard))
        }
        }
    
    
            
        }
        
        

#Preview {
    ContentView()
}
/* import SwiftUI, prev code
import AVFoundation

class SoundManager {
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "Alarm", withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error playing sound")
        }
    }
}

struct data{
    var Age: Int
    var Gender: Bool
    var prev: [String]
    var targ: [String]
    var schedule: [String]
    var NAPHA_Date: Date
    var Goals: [[String]]
    
    init(Age: Int, Gender: Bool, prev: [String], targ: [String], schedule: [String], NAPHA_Date: Date, Goals: [[String]]) {
        self.Age = Age
        self.Gender = Gender
        self.prev = prev
        self.targ = targ
        self.schedule = schedule
        self.NAPHA_Date = NAPHA_Date
        self.Goals = Goals
        
        UITabBar.appearance().isHidden = true
    }
    
    //    init(from decoder:  Decoder) throws {
    //        let container = try decoder.container(keyedBy: CodingKeys.self)
    //        self.Age = try container.decode(Float.self, forKey: .Age)
    //        self.Gender = try container.decode(Bool.self, forKey: .Gender)
    //        self.prev = try container.decode(Array.self, forKey: .prev)
    //        self.target = try container.decode(Array.self, forKey: .target)
    //        self.schedule = try container.decode(Array.self, forKey: .schedule)
    //        self.NAPHA_Date = try container.decode(Date.self, forKey: .NAPHA_Date)
    //    }
}

struct ContentView: View {
    
    @State var info = data(Age: 12, Gender: false, prev: ["","","","","",""], targ: ["","","","","",""], schedule: [], NAPHA_Date: Date.now, Goals: [])
    @State var selectedTimesCV: [Date] = []
    @State var selectedDaysCV: [Int] = []
    @State var Sex: Bool = true
    @State var age: Int = 12
    @State var prevWorkout = ""
    @State var firstTime = true
    @State var GoalSheetCV = false
    @State var AgeSheetCV = false
    @State var SchedSheetCV = false
    @State var selectedTab: Tab = .house
=======
>>>>>>> main
    @State var Startingpage = false
    var body: some View {
        TabView{
           
                if selectedTab == .house {
                    
                    Home(info: $info, prevWorkout: $prevWorkout, homeSelectedTimed: $selectedTimesCV, homeSelectedDays: $selectedDaysCV)
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                        .fullScreenCover(isPresented: $Startingpage) {
                            StartingPage(info: $info, TabViewSheet: false, showNewView: false, nextAction: {}) }
                    /* .fullScreenCover(isPresented: $AgeSheetCV){
                     =======
                     .fullScreenCover(isPresented: $AgeSheetCV){
                     >>>>>>> main
                     Age_Gender(info: $info, ageFirstTime: $firstTime, ageSheet: $AgeSheetCV)
                     }
                     .onChange(of: AgeSheetCV){
                     if AgeSheetCV == false{
                     SchedSheetCV = true
                     print("schedSheet CV is true")
                     }
                     }
                     .fullScreenCover(isPresented: $SchedSheetCV){
                     Scheduling_(info: $info, selectedDays: $selectedDaysCV, selectedTimes: $selectedTimesCV)
                     }
                     .onChange(of: SchedSheetCV){
                     if SchedSheetCV == false{
                     GoalSheetCV = true
                     print("GoalSheet CV is true")
                     }
                     }
                     .fullScreenCover(isPresented: $GoalSheetCV){
                     Goal_Page(info: $info, Sex: $Sex, Age: $age, GoalSheet: $GoalSheetCV)
                     }
                     .onChange(of: GoalSheetCV){
                     if GoalSheetCV == false{
                     firstTime = false
                     UserDefaults.standard.setValue(false, forKey: "fT")
                     
                     print("firstTime is now false")
                     }
                     } */
                    
                } else if selectedTab == .dumbbell{
                    Workout(prevWorkout: $prevWorkout, info: $info)
                        .tabItem {
                            ZStack{
                                Circle()
                                    .foregroundStyle(.blue)
                                    .frame(width: 60,height: 60)
                                Image(systemName: "dumbbell.fill")
                                    .scaleEffect(2)
                                    .foregroundStyle(.white)
                                Text("Workout Now!")
                                    .offset(y: 50)
                                    .font(.system(size: 13))
                                    .foregroundStyle(.black)
                            }
                        }
                } else {
                    Settings(info: $info, GoalSheet: $GoalSheetCV, AgeSheet: $AgeSheetCV, SchedSheet: $SchedSheetCV, selectedTimedSettings: $selectedTimesCV, selectedDaysSettings: $selectedDaysCV, Sex: $Sex, age: $age, ftSettings: $firstTime)
                        .tabItem {
                            Label("Settings", systemImage: "gearshape.fill")
                        }
                }
                VStack{
                    CustomTabBar(selectedTab: $selectedTab)
                    
                }
                
                .onAppear{
                    if let storedFirst = UserDefaults.standard.object(forKey: "fT") as? Bool {
                        firstTime = storedFirst
                        
                    }
                    if firstTime == true {
                        AgeSheetCV = true
                    }
                    
                    
                    if let storedSex = UserDefaults.standard.object(forKey: "sex") as? Bool {
                        info.Gender = storedSex
                        
                    }
                    if let storedAge = UserDefaults.standard.object(forKey: "age") as? Int{
                        info.Age = storedAge
                    }
                    UserDefaults.standard.setValue(UserDefaults.standard.bool(forKey: "Downloaded?") ?? true, forKey: "Downloaded?")
                    if(UserDefaults.standard.bool(forKey: "Downloaded?")){
                        UserDefaults.standard.setValue(Date.now, forKey: "DOWNlOADEDDATE")
                        UserDefaults.standard.setValue(false, forKey: "Downloaded?")
                    }
                    //print((UserDefaults.standard.object(forKey: "DOWNlOADEDDATE") as? Date)!.formatted(date: .abbreviated, time: .standard))
                }
            }
        }
    }

#Preview {
    ContentView()
} */
