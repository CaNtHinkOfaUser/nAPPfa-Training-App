//
//  SplashScreen.swift
//  Napha Training App
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var contentOpacity = 0.0

    var body: some View {
        Group {
            if isActive {
                ContentView()
            } else {
                ZStack {
                    LinearGradient(
                        colors: [Color(.systemBackground), Color(.secondarySystemBackground)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()

                    VStack(spacing: 16) {
                        Image("naapfa_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                            .shadow(color: .black.opacity(0.12), radius: 16, y: 8)

                        Text("nAPPfa")
                            .font(.system(size: 36, weight: .black, design: .rounded))

                        Text("nAPPfa training, neatly tracked.")
                            .font(.subheadline.weight(.medium))
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                    .opacity(contentOpacity)
                }
                .onAppear {
                    withAnimation(.easeOut(duration: 0.55)) {
                        contentOpacity = 1
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.15) {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
