import SwiftUI

struct StartingPage: View {
    
    @Binding var info: data
    @State var TabViewSheet = false
    @State var showNewView = false
    @Binding var ageFirstTime: Bool
    @Binding var ageSheet: Bool
    @Binding var Sex: Bool
    @Binding var Age: Int
    @Binding var goalSheet: Bool
    @Binding var schedSheet: Bool
    @Binding var selectedDays: [Int]
    @Binding var selectedTimes: [Date]
    @Binding var showLogin : Bool
    //var nextAction: () -> Void
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Image("final-image")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .scaleEffect(20)
                    .foregroundColor(.mint)
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 40)
                    .padding(.horizontal, 20)
                    .offset(y: 100)
                
                
                
                Image("hero-image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: 250)
                    .clipped()
                VStack() {
                    Text("nAPPfa")
                        .font(.title)
                        .scaleEffect(1.2)
                        .fontWeight(.bold)
                    Text("Achieve your goals and become more fitter with nAPPfa.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    
                    NavigationLink(destination: StartingTabView(info: $info,ageFirstTime: $ageFirstTime,ageSheet: $ageSheet,Sex: $Sex,Age: $Age,goalSheet: $goalSheet,selectedDays: $selectedDays,selectedTimes: $selectedTimes, schedSheet: $schedSheet, showLogin: $showLogin)) {
                        VStack {
                            Text("Get Started")
                                .font(.title)
                                .scaleEffect(0.9)
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .scaleEffect(0.9)
                            
                        }
                    }
                    
                }
                .padding(.bottom, 40)
                .offset(y: -40)
            }
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
        }
    }
}
struct StartingPage_Previews: PreviewProvider {
    static var previews: some View {
        StartingPage(info:.constant(data(Age: 0, Gender: false, prev: [], targ: [], schedule: [], NAPFA_Date: Date.now, Goals: [])), ageFirstTime: .constant(false), ageSheet: .constant(false), Sex: .constant(false), Age: .constant(0), goalSheet: .constant(false), schedSheet: .constant(false), selectedDays: .constant([0]), selectedTimes: .constant([]), showLogin: .constant(false) )
    }
}   
