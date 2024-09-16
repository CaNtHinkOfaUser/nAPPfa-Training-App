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
    @State var showLogin = false
    @State var selectedTab: Tab = .house
    @State var Startingpage = false
    var body: some View {
        
        if selectedTab == .house {
            Home(info: $info, prevWorkout: prevWorkout, homeSelectedTimed: $selectedTimesCV, homeSelectedDays: $selectedDaysCV)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .fullScreenCover(isPresented: $showLogin){
                    StartingPage(info: $info,ageFirstTime: $firstTime,ageSheet: $AgeSheetCV,Sex: $Sex,Age: $age,goalSheet: $GoalSheetCV,schedSheet: $SchedSheetCV, selectedDays: $selectedDaysCV,selectedTimes: $selectedTimesCV, showLogin: $showLogin)
                }
                .onChange(of: showLogin){
                    if showLogin == false {
                        firstTime = false
                        UserDefaults.standard.setValue(false, forKey: "fT")
                    }
                 }
            
        } else if selectedTab == .dumbbell{
            Workout(info: .constant(data(Age: 12, Gender: false, prev: ["","","","","",""], targ: ["","","","","",""], schedule: [], NAPHA_Date: Date.now, Goals: [])))
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
        } else if selectedTab == .gearshape{
            Settings(info: $info, GoalSheet: $GoalSheetCV, AgeSheet: $AgeSheetCV, SchedSheet: $SchedSheetCV, selectedTimedSettings: $selectedTimesCV, selectedDaysSettings: $selectedDaysCV, Sex: $Sex, age: $age, ftSettings: $firstTime)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        } else {
            Statistics()
                .tabItem{
                    Label("Statistics", systemImage: "chart.bar.fill")
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
                showLogin = true
                
                UserDefaults.standard.set(Date.now, forKey: "DOWNLOADDATE")
                print("hihi")
            }
            
            
            if let storedSex = UserDefaults.standard.object(forKey: "sex") as? Bool {
                info.Gender = storedSex
                
            }
            if let storedAge = UserDefaults.standard.object(forKey: "age") as? Int{
                info.Age = storedAge
            }
            
            if firstTime == true{
                showLogin = true
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
