//
//  Age_Gender.swift
//  Napha Training App
//
//  Created by Ishaan on 1/8/24.
//

import SwiftUI

struct Age_Gender: View {
    @Binding var info: data
    @State var Sex = true
    @State var age = 12
    
    var body: some View {
        VStack(alignment:.leading) {
            Text("About Me")
               .font(.title)
               .bold()
               .padding(.bottom)
            
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
                   .onChange(of: Sex){
                       UserDefaults.standard.setValue(Sex, forKey: "sex")
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
        Age_Gender(info:.constant(data(Age: 0, Gender: false, prev: [], targ: [], schedule: [], NAPHA_Date: Date.now, Goals: [])))
    }
}
