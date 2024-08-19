//
//  CustomTabBar.swift
//  Napha Training App
//
//  Created by Alvarez Marco Lorenzo Tanzon on 19/8/24.
//

import SwiftUI

enum Tab: String, CaseIterable{
    case house
    case dumbbell
    case gearshape
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    private var fillImage: String{
        selectedTab.rawValue + ".fill"
    }
    private var tabColour: Color {
        switch selectedTab {
        case .house:
            return .blue
        case .dumbbell:
            return .red
        case .gearshape:
            return .gray
        }
    }
    var body: some View {
        VStack{
            HStack{
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                        .foregroundColor(selectedTab == tab ? tabColour : .gray)
                        .font(.system(size: 22))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial)
            .cornerRadius(10)
            .padding()
        }
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.house))
}
