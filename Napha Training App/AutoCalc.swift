import SwiftUI

struct AutoCalcView: View {
    @Binding var info: data
    @State private var sitUps: Float = 0.0
    @State private var sitReach: Float = 0.0
    @State private var calcPicker: String = "Sit-Ups"
    @Environment(\.dismiss) private var dismiss

    let filterOptions: [String] = ["Sit-Ups", "Sit & Reach", "Pull-Up", "2.4KM", "Incline Pull-Up", "Standing Broad Jump"]

    // Define all grading systems in a dictionary
    let gradingSystems: [String: (Int, Bool, Int) -> String] = [
        "Sit-Ups": { age, sex, value in
            return calculateSitUpsGrade(age: age, sex: sex, sitUps: value)
        },
        "Sit & Reach": { age, sex, value in
            return calculateSitReachGrade(age: age, sex: sex, sitReach: value)
        }
        // Add more exercises here in the future
    ]

    static func calculateSitUpsGrade(age: Int, sex: Bool, sitUps: Int) -> String {
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

        let grades = sex ? maleGrades : femaleGrades

        var grade = ""
        if let ageGrades = grades[age] {
            for (gradeString, range) in ageGrades.sorted(by: { $0.value.lowerBound < $1.value.lowerBound }) {
                if range.contains(sitUps) {
                    grade = gradeString
                    break
                }
            }
        }
        return grade
    }

    static func calculateSitReachGrade(age: Int, sex: Bool, sitReach: Int) -> String {
        let maleGradesSitReach: [Int: [String: ClosedRange<Int>]] = [
    
            12: ["A": 39...100, "B": 36...39, "C": 32...35, "D": 28...31, "E": 23...27, "F": 0...22], 13: ["A": 41...100, "B": 38...41, "C": 34...37, "D": 30...33, "E": 25...29, "F": 0...24], 14: ["A": 43...100, "B": 40...43, "C": 36...39, "D": 32...35, "E": 27...31, "F": 0...26], 15: ["A": 45...100, "B": 42...45, "C": 38...41, "D": 34...37, "E": 29...33, "F": 0...28], 16: ["A": 47...100, "B": 44...47, "C": 40...43, "D": 36...39, "E": 31...35, "F": 0...30],
                       17: ["A": 48...100, "B": 45...48, "C": 41...44, "D": 37...40, "E": 32...36, "F": 0...31], 18: ["A": 48...100, "B": 45...48, "C": 41...44, "D": 37...40, "E": 32...36, "F": 0...31], 19: ["A": 48...100, "B": 45...48, "C": 41...44, "D": 37...40, "E": 32...36, "F": 0...31] ]
                   

        let femaleGradesSitReach: [Int: [String: ClosedRange<Int>]] = [
            12: ["A": 39...100, "B": 36...39, "C": 32...35, "D": 30...31, "E": 23...29, "F": 0...22], 13: ["A": 41...100, "B": 38...41, "C": 36...37, "D": 32...35, "E": 27...31, "F": 0...26], 14: ["A": 43...100, "B": 40...43, "C": 38...39, "D": 34...37, "E": 29...33, "F": 0...28], 15: ["A": 45...100, "B": 42...45, "C": 39...41, "D": 35...38, "E": 31...34, "F": 0...30], 16: ["A": 46...100, "B": 43...46, "C": 39...42, "D": 36...38, "E": 31...35, "F": 0...30], 17: ["A": 46...100, "B": 43...46, "C": 39...42, "D": 36...38, "E": 31...35, "F": 0...30], 18: ["A": 46...100, "B": 43...46, "C": 39...42, "D": 36...38, "E": 31...35, "F": 0...30], 19: ["A": 45...100, "B": 42...45, "C": 39...41, "D": 36...38, "E": 32...35, "F": 0...31] ]
        
        let grades = sex ? maleGradesSitReach : femaleGradesSitReach

        var grade = ""
        if let ageGrades = grades[age] {
            for (gradeString, range) in ageGrades.sorted(by: { $0.value.lowerBound < $1.value.lowerBound }) {
                if range.contains(sitReach) {
                    grade = gradeString
                    break
                }
            }
        }
        return grade
    }

    var body: some View {
       

        VStack {
            Text("AUTO CALCULATION")
                .font(.system(size: 20))
                .foregroundStyle(.gray)
                .offset(y: -160)
                .bold()

            Menu {
                Picker("Filter", selection: $calcPicker) {
                    ForEach(filterOptions, id: \.self) { option in
                        HStack {
                            Text(option)
                        }
                        .tag(option)
                    }
                }
            } label: {
                HStack {
                    Text("Exercise:")
                    Text("\(calcPicker)")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal)
                .background(.blue)
                .cornerRadius(10)
                .scaleEffect(0.7)
            }

            // Use a slider to change the value based on the selected exercise
            Slider(value: calcPicker == "Sit-Ups" ? $sitUps : $sitReach, in: 0...100, step: 1.0)
                .scaleEffect(0.6)

            let currentValue = calcPicker == "Sit-Ups" ? Int(sitUps) : Int(sitReach)
            let Grade = gradingSystems[calcPicker]?(info.Age, info.Gender, currentValue) ?? "N/A"

            Text(calcPicker == "Sit-Ups" ? String(format: "%.0f reps", sitUps) : String(format: "%.0f cm", sitReach))

            Text("Your grade is: \(Grade)")

            Button {
                dismiss()
            } label: {
                Text("Save")
            }
        }
    }
}

#Preview {
    AutoCalcView(info: .constant(data(Age: 0, Gender: false, prev: [], targ: [], schedule: [], NAPFA_Date: Date.now, Goals: [])))
}
