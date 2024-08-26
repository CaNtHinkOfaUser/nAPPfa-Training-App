//
//  Age_Gender.swift
//  Napha Training App
//
//  Created by Ishaan on 1/8/24.
//

import SwiftUI

struct Age_Gender: View {
    @Binding var start: Bool
    @Binding var info: data
    @State var Sex = true
    @State var age = 12
    @Binding var ageFirstTime: Bool
    @Binding var ageSheet: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment:.leading) {
            Text("About Me")
                .font(.title)
                .bold()
                .padding(.bottom)
            
                .offset(x: 20)
            
                .offset(x:10)
            
            
            Form {
                Section(header: Text("Personal Info")) {
                    Stepper(value: $age, in: 12...19, step: 1) {
                        Text("Age: \(age)")
                    }
                    
                    .onChange(of: age){
                        UserDefaults.standard.setValue(age, forKey: "age")
                    }
                    Picker("Sex", selection: $Sex) {
                        Text("Male").tag(true)
                        Text("Female").tag(false)
                    }
                    .labelsHidden()
                    .tint(.black)
                    .onChange(of: Sex){
                        UserDefaults.standard.setValue(Sex, forKey: "sex")
                    }
                    .offset(x: -10)
                }
                if(!start){
                    Button{
                        dismiss()
                    } label: {
                        Text("Save")
                            .foregroundStyle(.blue)
                    }
                }
            }
            .padding(.horizontal)
            
        }
        .onAppear{
            if let storedSex = UserDefaults.standard.object(forKey: "sex") as? Bool {
                Sex = storedSex
                
            }
            if let storedAge = UserDefaults.standard.object(forKey: "age") as? Int{
                age = storedAge
            }
            UserDefaults.standard.setValue(age, forKey: "age")
            UserDefaults.standard.setValue(Sex ,forKey: "sex")
            print("Age_gender\(age)\(Sex)")
        }
    }
}

struct Age_Gender_Previews: PreviewProvider {
    static var previews: some View {
        Age_Gender(start: .constant(false), info:.constant(data(Age: 0, Gender: false, prev: [], targ: [], schedule: [], NAPHA_Date: Date.now, Goals: [])), ageFirstTime: .constant(false), ageSheet: .constant(false))
    }
}
