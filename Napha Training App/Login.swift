import SwiftUI

struct StartingPage: View {
    var body: some View {
        VStack {
            // Header
            HStack {
                Image("final-image")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                Text("nAPPfa")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding(.top, 40)
            .padding(.horizontal, 20)

            // Hero Section
            VStack {
                Image("hero-image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: 250)
                    .clipped()
                VStack(alignment: .leading) {
                    Text("Get started with nAPPfa")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Organize your tasks and achieve your goals with nAPPfa, the ultimate Todo List app.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)

                // Call-to-Action Button
                Button(action: {
                    // Navigate to the next screen
                }) {
                    Text("Get Started")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.bottom, 40)
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct StartingPage_Previews: PreviewProvider {
    static var previews: some View {
        StartingPage()
    }
}   
