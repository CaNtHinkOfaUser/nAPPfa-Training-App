import SwiftUI

struct Goal_Page: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var exercises = ["Sit Ups", "Standing Broad Jump", "Sit & Reach", "Inclined Pull Ups", "Shuttle Run", "2.4km Run"]
    @State private var sitUps: Float = 0.0
    @State private var endCalc: String = ""
    @State private var autoCalc: Int = 0
    @Binding var info: data
    @State var Sex = true
    @State private var prev = ["", "", "", "", "", ""]
    @State private var targ = ["", "", "", "", "", ""]
    @State private var Nil = [false, false,  false, false, false, false]
    @State private var Goals: [[String]] = []
    @State private var age = 12
    @State private var grades = ["A", "B", "C", "D", "E", "F", "NA"]
    @State private var Days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    @Binding var selectedDays: [Int]
    @State private var toThrow: String = ""
    @State private var times : [Date] =  Array(repeating: Date(), count: 7)
    @Binding var selectedTimes : [Date]
    @State private var numberArray = [1,2,3,4,5,6,7]
    @State private var selectedTime = Date()
    @State private var selectedTimeInt: Int = 0
    @State private var selectedTimeOptional: Int? = 0
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium // Choose a date style (e.g., .short, .medium, .long)
        formatter.timeStyle = .short // Choose a time style (e.g., .none, .short, .medium, .long)
        return formatter
        
    }()
    
    func calculateSitUpsGrade(age: Int, sex: Bool, sitUps: Int) -> String {
        // Define the grading criteria for male and female
        let maleGrades: [Int: [String: ClosedRange<Int>]] = [
            12: ["A": 41...100, "B": 36...40, "C": 32...35, "D": 27...31, "E": 22...26,"F": 0...21],
            13: ["A": 43...100, "B": 38...41 , "C": 34...37, "D": 29...33, "E": 25...28, "F": 0...24],
            /*14: ["A": 43...100, "B": 40...41, "C": 37...39, "D": 34...36, "E": 29...33],
            15: ["A": 43...100, "B": 38...100, "C": 33...40, "D": 28...40],
            16: ["A": 43...100, "B": 39...100, "C": 34...40, "D": 29...40],
            17: ["A": 43...100, "B": 40...100, "C": 35...40, "D": 30...40],
            18: ["A": 43...100, "B": 41...100, "C": 36...40, "D": 31...40],
            19: ["A": 43...100, "B": 41...100, "C": 37...40, "D": 32...40],
            20: ["A": 43...100, "B": 43...100, "C": 38...40, "D": 33...40],
            21: ["A": 43...100, "B": 44...100, "C": 39...40, "D": 34...40],
            22: ["A": 43...100, "B": 45...100, "C": 40...40, "D": 35...40],
            23: ["A": 43...100, "B": 46...100, "C": 41...40, "D": 36...40],
            24: ["A": 43...100, "B": 47...100, "C": 42...40, "D": 37...40] */
]
        
        let femaleGrades: [Int: [String: ClosedRange<Int>]] = [
            12: ["A": 36...100, "B": 32...35, "C": 27...31, "D": 22...26, "E" : 17...21],
            13: ["A": 37...100, "B": 33...36, "C": 28...32, "D": 23...27, "E" : 18...22],
            /* 14: ["A": 38...100, "B": 34...37, "C": 29...33, "D": 24...28, "E" : 19...23],
            15: ["A": 39...100, "B": 35...38, "C": 30...34, "D": 25...29],
            16: ["A": 40...100, "B": 36...39, "C": 31...35, "D": 26...30],
            17: ["A": 41...100, "B": 37...40, "C": 32...36, "D": 27...31],
            18: ["A": 42...100, "B": 38...41, "C": 33...37, "D": 28...32],
            19: ["A": 43...100, "B": 39...42, "C": 34...38, "D": 29...33],
            20: ["A": 44...100, "B": 40...43, "C": 35...39, "D": 30...34],
            21: ["A": 45...100, "B": 41...44, "C": 36...40, "D": 31...35],
            22: ["A": 46...100, "B": 42...45, "C": 37...41, "D": 32...36],
            23: ["A": 47...100, "B": 43...46, "C": 38...42, "D": 33...37],
            24: ["A": 48...100, "B": 44...47, "C": 39...43, "D": 34...38] */
        ]
        let Grades = sex ? maleGrades : femaleGrades
        
        // Determine the grade based on the number of sit-ups
        var grade = ""
        if let ageGrades = Grades[age] {
            for (gradeString, range) in ageGrades.sorted(by: { $0.value.lowerBound < $1.value.lowerBound }) {
                if range.contains(sitUps) {
                   grade = gradeString
                }
            }
        }
        return grade
    }
    
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    Text("GOALS")
                        .font(.system(size: 60))
                        .bold()
                        .offset(y: 1)
                    Image("TargetBoard")
                        .resizable()
                        .scaleEffect(0.4)
                        .offset(y: -150)
                    
                    
                    Text("ABOUT ME")
                        .font(.system(size: 20))
                        .foregroundStyle(.gray)
                        .offset(y: -260)
                        .position(x: 100)
                    VStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 190, height: 40)
                                .foregroundColor(Color("UIColour"))
                            Stepper(value: $age, in: 12...24, step: 1){
                                Text("Age: \(age)")
                            }
                            .padding(.horizontal, 50)
                        }
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 190, height: 40)
                                .foregroundColor(Color("UIColour"))
                            Picker("Sex",selection: $Sex){
                                Text("Male").tag(true)
                                Text("Female").tag(false)
                            }
                            .offset(x: Sex ? -60 : -50)
                            .accentColor(.black)
                        }
                    }
                    .padding(.horizontal, 60)
                    .offset(y: -250)
                    .offset(x: -75)
                    
                    Text("AUTO CALCULATION")
                        .font(.system(size: 20))
                        .foregroundStyle(.gray)
                        .offset(y: -160)
                        .position(x: 153)
                    Slider(value: $sitUps, in: 0...100, step: 1.0)
                        .scaleEffect(0.6)
                        .offset(y: -130)
                        .position(x: 150)
                        .onChange(of: sitUps){
                            endCalc = "\(calculateSitUpsGrade(age: age, sex: Sex, sitUps: autoCalc))"
                        }
                    Text(String(format: "%.0f", sitUps))
                    Text("Your grade is: \(calculateSitUpsGrade(age: age, sex: Sex, sitUps: Int(sitUps)))")
                }
                
                Text("RESULTS")
                    .font(.system(size: 20))
                    .foregroundStyle(.gray)
                    .offset(y: -130)
                    .position(x: 100)
                
                Grid{
                    
                    let offset = Nil.sorted { $0 && !$1 }[0]
                    
                    GridRow{
                        Text("Previous\nGrade")
                            .font(.system(size: 17))
                            .offset(x: 180)
                            .padding()
                            .fixedSize(horizontal: true, vertical: true)
                            .multilineTextAlignment(.center)
                            .gridColumnAlignment(.center)
                            .lineLimit(2)
                        Text("Target\nGrade")
                            .font(.system(size: 17))
                            .offset(x: 180)
                            .padding()
                            .multilineTextAlignment(.center)
                            .gridColumnAlignment(.leading)
                            .lineLimit(2)
                    }
                    
                    ForEach(exercises.indices, id:\.self){ index in
                        GridRow{
                            Button{
                                withAnimation{
                                    Nil[index].toggle()
                                }
                                targ[index] = Nil[index] ? "": "false"
                                prev[index] = Nil[index] ? "": "false"
                            } label: {
                                Label("", systemImage:
                                        Nil[index] ? "checkmark.square.fill" : "checkmark.square")
                                .font(.system(size: 20))
                            }
                            .offset(x: offset ? 23 : 20)
                            
                            Text(exercises[index])
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(width: 100)
                                .offset(x: offset ? 10 : 0)
                            
                            if Nil[index]{
                                Picker("prev", selection: $prev[index]){
                                    ForEach(grades, id: \.self){ grade in
                                        Text(grade).tag(grade)
                                    }
                                }
                                
                                Picker("targ", selection: $targ[index]){
                                    ForEach(grades, id: \.self){ grade in
                                        Text(grade).tag(grade)
                                    }
                                }
                                .gridCellAnchor(.trailing)
                            }
                            Spacer()
                        }
                        .padding(.vertical, 10)
                    }
                }
                .offset(y: -150)
                
                DatePicker(selection: $info.NAPHA_Date, displayedComponents: .date){
                    Text("Select your Napha Data")
                }
                .padding(.horizontal, 50)
                .offset(y: -150)
                
                Grid{
                    ForEach(Goals.indices, id: \.self){ index in
                        GridRow{
                            TextField(text: $Goals[index][0]){
                                Text("input goal for exercise...")
                            }
                            .textFieldStyle(.roundedBorder)
                            .offset(x: 30)
                            Picker("exercise", selection: $Goals[index][1]){
                                ForEach(exercises, id: \.self){ exercise in
                                    Text(exercise).tag(exercise)
                                }
                            }
                            .offset(x: -30)
                        }
                        .padding(.horizontal, 30)
                        .padding(.vertical, -30)
                    }
                    .padding(.vertical)
                    .offset(y: -140)
                    
                    Button{
                        Goals.append(["", ""])
                    } label: {
                        Text("Create New Goal")
                    }
                    .offset(y: -140)
                }
                
                
                Text("SCHEDULE")
                    .font(.system(size: 20))
                    .foregroundStyle(.gray)
                    .offset(x: -110)
                    .offset(y: -110)
                
                HStack(spacing: 15){
                    ForEach(Days.indices, id: \.self){day in  Text(String(Days[day]).prefix(1))
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 35, height: 35)
                            .background(Circle().fill(selectedDays.contains(day) ? Color.blue : Color.gray)
                                .animation(.easeInOut(duration: 0.3), value: selectedDays))
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)){
                                    if selectedDays.contains(day){
                                        selectedTimes.remove(at: selectedDays.firstIndex(of: day)!)
                                        selectedDays.removeAll {$0 == day}
                                        
                                    } else {
                                        selectedDays.append(day)
                                        selectedTimes.append(times[day])
                                    }
                                }
                            }
                    }
                    .bold()
                    .offset(y: -90)
                }
                ForEach(selectedTimes, id: \.self){ i in
                    Text(dateFormatter.string(from: i))
                    //used for testing, remove later
                }
                ForEach(selectedDays, id: \.self){i in
                    Text((String(i+1)))
                }
                Text("TIMING")
                                    .font(.system(size: 20))
                                    .foregroundStyle(.gray)
                                    .offset(x: -130)
                                    .offset(y: -60)
                                VStack(spacing: 30){
                                    
                                    ForEach(selectedDays.sorted(), id:
                                        \.self){selectedDay in
                                        HStack(alignment: .center){
                                            Text(Days[selectedDay].prefix(3))
                                                .offset(x: -90)
                                                .font(.system(size: 25))
                                                .frame(width: 50, alignment: .leading)
                                            DatePicker(Days[selectedDay].prefix(3), selection: $times[selectedDay]
                                                       , displayedComponents: .hourAndMinute)
                                                .labelsHidden()
                                                .onChange(of: times[selectedDay]){ if selectedDays.contains(selectedDay){
                                                    selectedTimes.remove(at: selectedDays.firstIndex(of: selectedDay)!)
                                                    selectedDays.removeAll {$0 == selectedDay}
                                                    selectedDays.append(selectedDay)
                                                    selectedTimes.append(times[selectedDay])
                                                }
                                                    
                                                }
                                            
                                        }
                                        
                                    }
                                }

                                Button{
                                    info.Gender = Sex
                                    info.target = targ
                                    info.prev = prev
                                    info.Goals = Goals
                                    info.Age = age
                                    
                                    dismiss()
                                
                                    
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color(.green))
                                            .frame(width: 70, height: 50)
                                        Text("Save")
                                            .foregroundStyle(.white)
                                    }
                                }
                                .offset(y: 0)
                            }
                        }
                    }
                }


#Preview {
    Goal_Page(info: .constant(data(Age: 0, Gender: false, prev: [], target: [], schedule: [], NAPHA_Date: Date.now, Goals: [])), selectedDays: .constant([]), selectedTimes: .constant([]))
}



