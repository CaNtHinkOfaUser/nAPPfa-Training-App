import SwiftUI

struct Goal_Page: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var exercises = ["Sit Ups", "Standing Broad Jump", "Sit & Reach", "Inclined Pull Ups", "Shuttle Run", "2.4km Run"]
    @State private var sitUps: Float = 0.0
    @State private var endCalc: String = ""
    @State private var autoCalc: Int = 0
    @Binding var info: data
    @Binding var Sex: Bool
    @State private var prev = ["", "", "", "", "", ""]
    @State private var targ = ["", "", "", "", "", ""]
    @State private var Nil = [false, false,  false, false, false, false]
    @State private var Goals: [[String]] = []
    @State private var grades = ["A", "B", "C", "D", "E", "F", "NA"]
    @State var showAlert = false
    @State var SitUpGrade = ""
    
    
    
    func calculateSitUpsGrade(age: Int, sex: Bool, sitUps: Int) -> String {
        // Define the grading criteria for male and female
        let maleGrades: [Int: [String: ClosedRange<Int>]] = [
            12: ["A": 42...100, "B": 36...41, "C": 32...35, "D": 27...31, "E": 22...26, "F": 0...21],
            13: ["A": 43...100, "B": 38...42, "C": 34...37, "D": 29...33, "E": 25...28, "F": 0...24],
            14: ["A": 43...100, "B": 40...42, "C": 37...39, "D": 33...36, "E": 29...32, "F": 0...28],
            15: ["A": 43...100, "B": 40...42, "C": 37...39, "D": 34...36, "E": 30...33, "F": 0...33],
            16: ["A": 43...100, "B": 40...42, "C": 37...39, "D": 34...36, "E": 31...33, "F": 0...33],
            17: ["A": 43...100, "B": 40...42, "C": 37...39, "D": 34...36, "E": 31...33, "F": 0...33],
            18: ["A": 43...100, "B": 40...42, "C": 37...39, "D": 34...36, "E": 31...33, "F": 0...33],
            19: ["A": 43...100, "B": 40...42, "C": 37...39, "D": 34...36, "E": 31...33, "F": 0...33],
        ]
        
        let femaleGrades: [Int: [String: ClosedRange<Int>]] = [
            12: ["A": 30...100, "B": 25...29, "C": 21...24, "D": 17...20, "E" : 13...16, "F": 0...12],
            13: ["A": 31...100, "B": 26...30, "C": 22...25, "D": 18...21, "E" : 14...17, "F": 0...13],
            14: ["A": 31...100, "B": 28...30, "C": 24...27, "D": 20...23, "E" : 16...19, "F": 0...15],
            15: ["A": 31...100, "B": 29...30, "C": 25...28, "D": 21...24, "E" : 17...20, "F": 0...16],
            16: ["A": 31...100, "B": 29...30, "C": 26...28, "D": 22...25, "E" : 18...21, "F": 0...17],
            17: ["A": 31...100, "B": 29...30, "C": 27...28, "D": 23...26, "E" : 19...22, "F": 0...18],
            18: ["A": 31...100, "B": 29...30, "C": 27...28, "D": 24...26, "E" : 21...23, "F": 0...19],
            19: ["A": 31...100, "B": 29...30, "C": 27...28, "D": 24...26, "E" : 21...23, "F": 0...20],
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
            ScrollView {
                VStack {
                    VStack {
                        Text("GOALS")
                            .font(.system(size: 60))
                            .bold()
                            .offset(y: 1)
                        Image("TargetBoard")
                            .resizable()
                            .scaleEffect(0.4)
                            .offset(y: -150)
                        
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
                                endCalc = "\(calculateSitUpsGrade(age: info.Age, sex: Sex, sitUps: autoCalc))"
                                UserDefaults.standard.setValue(sitUps, forKey: "storedSit")
                                
                            }
                        
                        Text(String(format: "%.0f", sitUps))
                            .offset(y: -200)
                            .position(x: 150)
                        Text("Your grade is: \(calculateSitUpsGrade(age: info.Age, sex: Sex, sitUps: Int(sitUps)))")
                            .offset(y: -140)
                            .position(x: 150)
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
                                        UserDefaults.standard.setValue(Nil, forKey: "Lin")
                                    }
                                    targ[index] = Nil[index] ? "": "false"
                                    prev[index] = Nil[index] ? "": "false"
                                    UserDefaults.standard.setValue(prev, forKey: "prev")
                                    UserDefaults.standard.setValue(targ, forKey: "targ")
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
                                    .onChange(of: prev[index]){
                                        UserDefaults.standard.setValue(prev, forKey: "prev")
                                    }
                                    
                                    Picker("targ", selection: $targ[index]){
                                        ForEach(grades, id: \.self){ grade in
                                            Text(grade).tag(grade)
                                        }
                                    }
                                    .onChange(of: targ[index]){
                                        UserDefaults.standard.setValue(targ, forKey: "targ")
                                    }
                                    
                                    .gridCellAnchor(.trailing)
                                }
                                Spacer()
                            }
                            .padding(.vertical, 10)
                        }
                    }
                    .offset(y: -150)
                    
                    
                    
                    Grid{
                        ForEach(Goals.indices, id: \.self){ index in
                            GridRow{
                                TextField(text: $Goals[index][0]){
                                    Text("input goal for exercise...")
                                }
                                .onChange(of: Goals[index][0]){
                                    UserDefaults.standard.setValue(Goals, forKey: "sGoals")
                                }
                                .textFieldStyle(.roundedBorder)
                                .offset(x: 30)
                                Picker("exercise", selection: $Goals[index][1]){
                                    ForEach(exercises, id: \.self){ exercise in
                                        Text(exercise).tag(exercise)
                                    }
                                    .onChange(of: Goals[index][1]){
                                        UserDefaults.standard.setValue(Goals, forKey: "sGoals")
                                        
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
                    Button(action:  {
                        showAlert.toggle()
                        
                    }) { Text("Save")
                    }
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Changing the results will alter workout programme."),
                              primaryButton: .destructive(Text("Save"), action:  {
                            info.Gender = Sex
                            info.target = targ
                            info.prev = prev
                            info.Goals = Goals
                            dismiss()
                            
                        }),
                              secondaryButton: .cancel())
                    })
                    .offset(y: 0)// Add padding to the top
                    .padding()
                    .ignoresSafeArea(.all, edges: .top)
                    .background(Color.green)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .font(.headline)
                    
                    // Ignore safe area at the top
                }
            }
            
        }
        .onAppear{
            if let storedSitUps = UserDefaults.standard.object(forKey: "storedSit") as? Float{
                sitUps = storedSitUps
            }
            UserDefaults.standard.setValue(sitUps, forKey: "storedSit")
            
            if let storedPrev = UserDefaults.standard.object(forKey: "prev") as? [String] {
                prev = storedPrev
            }
            UserDefaults.standard.setValue(prev, forKey: "prev")
            
            if let storedTarg = UserDefaults.standard.object(forKey: "targ") as? [String] {
                targ = storedTarg
            }
            UserDefaults.standard.setValue(targ, forKey: "targ")
            
            if let Lin = UserDefaults.standard.object(forKey: "Lin") as? [Bool] {
                Nil = Lin
            }
            UserDefaults.standard.setValue(Nil, forKey: "Lin")
            
            if let storedGoals = UserDefaults.standard.object(forKey: "sGoals") as? [[String]] {
                Goals = storedGoals
            }
            UserDefaults.standard.setValue(Goals, forKey: "sGoals")
        }
    }
}
#Preview {
    Goal_Page(info: .constant(data(Age: 0, Gender: false, prev: [], target: [], schedule: [], NAPHA_Date: Date.now, Goals: [])), Sex: .constant(true), showAlert: false)
}

