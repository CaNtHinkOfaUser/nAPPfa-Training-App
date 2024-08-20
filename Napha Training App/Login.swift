import SwiftUI

struct StartingPage: View {
    
    @Binding var info: data
    @State var TabViewSheet = false
    @State var showNewView = false
    var nextAction: () -> Void
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
                
                
                // Hero Section
                
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
                    
                    NavigationLink(destination: StartingTabView(StartingTabViewSheet: .constant(false), info: $info)) {
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
        StartingPage(info:.constant(data(Age: 0, Gender: false, prev: [], targ: [], schedule: [], NAPHA_Date: Date.now, Goals: [])), nextAction: {} )
    }
}   
