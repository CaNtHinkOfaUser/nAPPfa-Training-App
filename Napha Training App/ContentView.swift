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
    
    var body: some View {
        TabView{
            Home(info: $info, prevWorkout: $prevWorkout, homeSelectedTimed: $selectedTimesCV, homeSelectedDays: $selectedDaysCV)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
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
            Settings(info: $info, selectedTimedSettings: $selectedTimesCV, selectedDaysSettings: $selectedDaysCV, Sex: $Sex, age: $age)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .onAppear{
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
