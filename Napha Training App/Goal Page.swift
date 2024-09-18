import SwiftUI
struct Goal_Page: View {
    @State var clear = false
    @Environment(\.dismiss) private var dismiss
    @Binding var start: Bool
    @State private var exercises = ["Sit Ups", "Standing Broad Jump", "Sit & Reach", "Inclined Pull Ups", "Shuttle Run", "2.4km Run"]
    
    @State private var endCalc: String = ""
    @State private var autoCalc: Int = 0
    @Binding var info: data
    @Binding var Sex: Bool
    @Binding var Age: Int
    @Binding var GoalSheet: Bool
    @State private var prev = ["", "", "", "", "", ""]
    @State private var targ = ["", "", "", "", "", ""]
    @State private var Nil = [false, false,  false, false, false, false]
    @State private var Goals: [[String]] = []
    @State private var grades = ["A", "B", "C", "D", "E", "F", "NA"]
    @State var showAlert = false
    @State private var sitUps: Float = 0.0
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack {
                    if start {
                        GeometryReader { geometry in
                            
                            // Full capsule background
                            HStack {
                                Text("Step 2 of 3")
                                ZStack(alignment: .leading) {
                                    
                                    Capsule()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 240,height: 10)
                                    Capsule()
                                        .fill(Color.green)
                                        .frame(width: 160, height: 10)
                                    
                                    
                                } .offset(x: 10)
                            } .offset(x: 30)
                            // 1/3 Capsule
                            
                            
                            // 3/3 Capsule
                            
                        }
                    }
                    VStack {
                        Text("GOALS")
                            .font(.system(size: 60))
                            .bold()
                            .offset(y: 1)
                        Image("TargetBoard")
                            .resizable()
                            .scaleEffect(0.5)
                            .offset(y: 70)
                            .position(x: 180)
                        
                        Link("Napfa Standards: Male", destination: URL(string: "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhpo5erUUSr2VDuBhYj_7rU-CH1IXq8kM3VHRpt9CrdKDSy9-AUBk6xIjO0XU_F7Pzy7VvZlbKMhJMwXKeshhxmefpUpcbYwqG4dIJ9ZBXX5KyOJHbkKTVeX5wMYMqAVOWGirlwe5Ez8dc/s1600/napfa+sec_0001.jpg")!)
                            .offset(y: -200)
                        Link("Napfa Standards: Female", destination: URL(string: "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiZlF2X2fKqbhaLL3Y49sbaRuk8Thxa1mAtQ0ZSqrVn6w1yAyN2LXgWXvFP9EohhreOH-FpXI9b_XB8PUQgEpZkmBIz_LDLZGzD35gq4_Vc_oWTDNwBrS3-TBFRgwlAfRBUBlRK5Sbypns/s1600/napfa+sec_0002.jpg")!)
                            .offset(y: -200)
                        
                        NavigationLink(destination: AutoCalcView(info: $info), label: {
                           
                                Text(Image(systemName: "info.circle"))
                                             
                                               .baselineOffset(1)
                                           +
                                           Text(" Do you want to calculate your grade?")
                                               .bold()
                            
                           
                        })
                        .offset(y: -200)
                        Text("RESULTS:")
                            .font(.system(size: 20))
                            .foregroundStyle(.gray)
                            .offset(y: -90)
                            .position(x: 70)
                            .bold()
                        
                        Grid{
                            
                            let offset = Nil.sorted { $0 && !$1 }[0]
                            
                            GridRow{
                                Text("Previous\nGrade:")
                                    .font(.system(size: 17))
                                    .offset(x: 180)
                                    .padding()
                                    .fixedSize(horizontal: true, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .gridColumnAlignment(.center)
                                    .lineLimit(2)
                                Text("Target\nGrade:")
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
                                    .offset(x: offset ? -23 : -23)
                                    
                                    Text(exercises[index])
                                        .multilineTextAlignment(.center)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .frame(width: 100)
                                        .offset(x: offset ? -50 : -50)
                                    
                                    if Nil[index]{
                                        Picker("prev", selection: $prev[index]){
                                            ForEach(grades, id: \.self){ grade in
                                                Text(grade).tag(grade)
                                            }
                                        }
                                        .offset(x: -10)
                                        .onChange(of: prev[index]){
                                            UserDefaults.standard.setValue(prev, forKey: "prev")
                                        }
                                        
                                        Picker("targ", selection: $targ[index]){
                                            ForEach(grades, id: \.self){ grade in
                                                Text(grade).tag(grade)
                                            }
                                        }
                                        .offset(x: 20)
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
                            Section{
                                ForEach(Goals.indices, id: \.self){ index in
                                    HStack{
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
                                    }
                                    .padding(.horizontal, 30)
                                    .padding(.vertical, -30)
                                }
                                
                                .padding(.vertical)
                                .offset(y: -140)
                                
                                Button{
                                    Goals.append(["", "Sit Ups"])
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .frame(width: 150,height: 50)
                                        Text("Create New Goal")
                                            .foregroundColor(.white)
                                    }
                                }
                                .offset(y: -130)
                                
                                
                                Button{
                                    clear = true
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .frame(width: 150,height: 50)
                                        Text("Clear all goals")
                                            .foregroundColor(.white)
                                    }
                                }
                                .offset(y: -130)
                                .alert(isPresented: $clear){
                                    Alert(
                                        title: Text("Clear goals"),
                                        message: Text("Are you would like to clear goals?"),
                                        primaryButton: .destructive(Text("Yes")){
                                            Goals = []
                                        },
                                        secondaryButton: .cancel(Text("No"))
                                    )
                                }
                                .onChange(of: Goals){
                                    UserDefaults.standard.setValue(Goals, forKey: "sGoals")
                                    
                                }
                            }
                        }
                        if(!start){
                            Button{
                                info.targ = targ
                                info.prev = prev
                                info.Goals = Goals
                                dismiss()
                                
                                
                            } label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color(.green))
                                        .frame(width: 10, height: 20)
                                    Text("Save")
                                        .foregroundStyle(.white)
                                }
                            }
                            .offset(y: 0)// Add padding to the top
                            .padding()
                            .ignoresSafeArea(.all, edges: .top)
                            .background(Color.green)
                            .cornerRadius(20)
                            .foregroundColor(.white)
                            .font(.headline)
                            
                            // Ignore safe area at the top
                        }
                        else{
                           
                          
                        
                            VStack{
                            }
                            .onChange(of: targ) {
                                info.targ = targ
                            }
                            .onChange(of: prev) {
                                info.prev = prev
                            }
                            .onChange(of: Goals) {
                                info.Goals = Goals
                            }
                        }
                    }
                }
                
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Changing the results will alter workout programme."),
                          primaryButton: .destructive(Text("Save"), action:  {
                        info.targ = targ
                        info.prev = prev
                        info.Goals = Goals
                        dismiss()
                        
                    }),
                          secondaryButton: .cancel())
                })
                .onAppear{
                    if let storedSex = UserDefaults.standard.object(forKey: "sex") as? Bool {
                        info.Gender = storedSex
                        
                    }
                    if let storedAge = UserDefaults.standard.object(forKey: "age") as? Int{
                        info.Age = storedAge
                    }
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
    }
}

        
    

#Preview {
    Goal_Page(start: .constant(false), info: .constant(data(Age: 0, Gender: false, prev: [], targ: [], schedule: [], NAPFA_Date: Date.now, Goals: [])), Sex: .constant(true), Age: .constant(0), GoalSheet: .constant(false), showAlert: false)
}


