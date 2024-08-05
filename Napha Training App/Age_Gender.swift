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
            Text(String(Sex))
            
            Form {
                Section(header: Text("Personal Info")) {
                    Stepper(value: $age, in: 12...19, step: 1) {
                        Text("Age: \(age)")
                    }
                    
                    Picker("Sex", selection: $Sex) {
                        Text("Male").tag(true)
                        Text("Female").tag(false)
                    }
                   .labelsHidden()
                   .onChange(of: Sex){ newSex, _ in
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
            UserDefaults.standard.setValue(Sex ,forKey: "sex")
        }
    }
}

struct Age_Gender_Previews: PreviewProvider {
    static var previews: some View {
        Age_Gender(info:.constant(data(Age: 0, Gender: false, prev: [], target: [], schedule: [], NAPHA_Date: Date.now, Goals: [])))
    }
}
