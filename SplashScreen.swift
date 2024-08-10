//
//  SplashScreen.swift
//  Napha Training App
//
//  Created by Ishaan on 9/8/24.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
            
        } else {
            
            VStack {
                VStack {
                    Image("naapfa_logo")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                        .scaleEffect(0.8)
                        .cornerRadius(20)
                    Text("nAPPfa")
                        .font(Font.custom("Baskerbille-Bold", size: 26))
                        .foregroundColor(.black.opacity(0.80))
                    
                    
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.2 )) {
                        self.size = 0.9
                        self.opacity = 1.0
                        
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.isActive = true
                }
            }
        }
    }
}
#Preview {
    SplashScreen()
}
