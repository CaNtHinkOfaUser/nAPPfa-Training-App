//
//  Age_Gender.swift
//  Napha Training App
//
//  Created by Ishaan on 1/8/24.
//

import SwiftUI

struct Age_Gender: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var info: data
    @State var Sex = true
    @State var age = 12
    var body: some View {
        VStack {
          
            
            
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
                    Stepper(value: $age, in: 12...19, step: 1){
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
                Button{
                    info.Age = age
                    dismiss()
                } label: {
                    Text("done")
                }
            }
            .padding(.horizontal, 60)
            .offset(y: -250)
            .offset(x: -75)
        }
    }
}

#Preview {
    Age_Gender(info: .constant(data(Age: 0, Gender: false, prev: [], target: [], schedule: [], NAPHA_Date: Date.now, Goals: [])))
}
