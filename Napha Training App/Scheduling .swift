//
//  Scheduling .swift
//  Napha Training App
//
//  Created by Ishaan on 2/8/24.
//

import SwiftUI

struct Scheduling_: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var info: data
    @State private var Days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    @Binding var selectedDays: [Int]
    @State private var toThrow: String = ""
    @State private var times : [Date] =  Array(repeating: Date(), count: 7)
    @Binding var selectedTimes : [Date]
    @Binding var schedSheet: Bool
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
    var body: some View {
        VStack {
            Text("SCHEDULE")
                .font(.system(size: 20))
                .foregroundStyle(.gray)
            DatePicker("Select your Napha Date", selection: $info.NAPHA_Date, displayedComponents: .date)
                .padding(.horizontal, 50)
            
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
                                    UserDefaults.standard.setValue(selectedTimes, forKey: "ST")
                                    UserDefaults.standard.setValue(selectedDays, forKey: "SD")
                                    
                                    
                                } else {
                                    selectedDays.append(day)
                                    selectedTimes.append(times[day])
                                    UserDefaults.standard.setValue(selectedTimes, forKey: "ST")
                                    UserDefaults.standard.setValue(selectedDays, forKey: "SD")
                                }
                            }
                        }
                }
                .bold()
            }
            /*(ForEach(selectedTimes, id: \.self){ i in
             Text(dateFormatter.string(from: i))
             //used for testing, remove later
             }
             ForEach(selectedDays, id: \.self){i in
             Text((String(i+1)))
             }*/
            Text("TIMING")
                .font(.system(size: 20))
                .foregroundStyle(.gray)
            VStack(spacing: 30){
                ForEach(selectedDays.sorted(), id: \.self){selectedDay in
                    HStack(alignment: .center){
                        Text(Days[selectedDay].prefix(3))
                            .font(.system(size: 25))
                            .frame(width: 50, alignment: .leading)
                        DatePicker("", selection: $times[selectedDay], displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .onChange(of: times[selectedDay]){
                                if selectedDays.contains(selectedDay){
                                selectedTimes.remove(at: selectedDays.firstIndex(of: selectedDay)!)
                                selectedDays.removeAll {$0 == selectedDay}
                                selectedDays.append(selectedDay)
                                selectedTimes.append(times[selectedDay])
                                UserDefaults.standard.setValue(selectedDays, forKey: "SD")
                                UserDefaults.standard.setValue(selectedTimes, forKey: "ST")
                                UserDefaults.standard.setValue(times, forKey: "times")
                                
                            } else{
                                UserDefaults.standard.setValue(selectedDays, forKey: "SD")
                                UserDefaults.standard.setValue(selectedTimes, forKey: "ST")
                                UserDefaults.standard.setValue(times, forKey: "times")
                                
                            }
                            }
                    }
                }
            }
            Text("Please choose at least three days")
            .foregroundStyle(selectedDays.count<3 ? .red : .black)}
        Button{
            
            dismiss()
            
            
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.green))
                    .frame(width: 100, height: 50)
                Text("Save")
                    .foregroundStyle(.white)
            }
        }
        .onAppear{
            
          if let storedST = UserDefaults.standard.object(forKey: "ST") as? [Date]{
                selectedTimes = storedST
            }
            UserDefaults.standard.setValue(selectedTimes, forKey: "ST")
            if let storedSD = UserDefaults.standard.object(forKey: "SD") as? [Int]{
                selectedDays = storedSD
            }
            UserDefaults.standard.setValue(selectedDays, forKey: "SD")
            if let storedTimes = UserDefaults.standard.object(forKey: "times") as? [Date]{
                times = storedTimes
            }
            UserDefaults.standard.setValue(times, forKey: "times")
        }
    }
}
#Preview {
    Scheduling_(info: .constant(data(Age: 0, Gender: false, prev: [], targ: [], schedule: [], NAPHA_Date: Date.now, Goals: [])), selectedDays: .constant([]), selectedTimes: .constant([]), schedSheet: .constant(false))
}
