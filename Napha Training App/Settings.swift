//  Settings.swift
//  Napha Training App

import SwiftUI

struct Settings: View {
    @Binding var info: data
    @Binding var GoalSheet: Bool
    @Binding var AgeSheet: Bool
    @Binding var SchedSheet: Bool
    @Binding var selectedTimedSettings: [Date]
    @Binding var selectedDaysSettings: [Int]
    @Binding var Sex: Bool
    @Binding var age: Int
    @Binding var ftSettings: Bool

    @State private var goalSheetSettings = false
    @State private var ageSheetSettings = false
    @State private var autoCalcSettings = false
    @State private var appeared = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 14) {
                    settingsHero

                    settingsGroup(title: "Training") {
                        SettingsRow(title: "Goal setting", subtitle: "Grades & custom goals", icon: "target", color: .blue) {
                            goalSheetSettings = true
                        }
                        SettingsRow(title: "Auto calculation", subtitle: "Raw score to grade", icon: "function", color: .purple) {
                            autoCalcSettings = true
                        }
                        SettingsRow(title: "Scheduling", subtitle: "Days, times, reminders", icon: "calendar.badge.clock", color: .green) {
                            SchedSheet = true
                        }
                    }

                    settingsGroup(title: "Profile") {
                        SettingsRow(title: "Age and sex", subtitle: "Used for grade tables", icon: "person.crop.circle", color: .orange) {
                            ageSheetSettings = true
                        }
                    }
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 110)
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : 12)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.86)) {
                    appeared = true
                }
            }
            .fullScreenCover(isPresented: $goalSheetSettings) {
                Goal_Page(start: .constant(false), info: $info, Sex: $Sex, Age: $age, GoalSheet: $GoalSheet)
            }
            .fullScreenCover(isPresented: $autoCalcSettings) {
                AutoCalcView(info: $info)
            }
            .fullScreenCover(isPresented: $ageSheetSettings) {
                Age_Gender(start: .constant(false), info: $info, ageFirstTime: $ftSettings, ageSheet: $AgeSheet)
            }
            .fullScreenCover(isPresented: $SchedSheet) {
                Scheduling_(
                    start: .constant(false),
                    info: $info,
                    selectedDays: $selectedDaysSettings,
                    selectedTimes: $selectedTimedSettings,
                    schedSheet: $SchedSheet
                )
            }
        }
    }

    private var settingsHero: some View {
        HStack(spacing: 14) {
            Image("naapfa_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 56, height: 56)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

            VStack(alignment: .leading, spacing: 4) {
                Text("nAPPfa")
                    .font(.title2.weight(.bold))
                Text("Train smarter for all 6 stations.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(16)
        .background(.background, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private func settingsGroup(title: String, @ViewBuilder rows: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .padding(.leading, 4)
            VStack(spacing: 0) {
                rows()
            }
            .background(.background, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
    }
}

private struct SettingsRow: View {
    let title: String
    var subtitle: String = ""
    let icon: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(color)
                    .frame(width: 40, height: 40)
                    .background(color.opacity(0.14), in: RoundedRectangle(cornerRadius: 12, style: .continuous))

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.body.weight(.semibold))
                        .foregroundStyle(.primary)
                    if !subtitle.isEmpty {
                        Text(subtitle)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.tertiary)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(
            info: .constant(data(Age: 0, Gender: false, prev: [], targ: [], schedule: [], NAPFA_Date: Date.now, Goals: [])),
            GoalSheet: .constant(false),
            AgeSheet: .constant(false),
            SchedSheet: .constant(false),
            selectedTimedSettings: .constant([]),
            selectedDaysSettings: .constant([]),
            Sex: .constant(true),
            age: .constant(0),
            ftSettings: .constant(true)
        )
    }
}
