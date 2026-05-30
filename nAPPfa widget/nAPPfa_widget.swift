//
//  nAPPfa_widget.swift
//  nAPPfa widget
//
//  Created by Ishaan on 14/10/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), nextWorkout: Date().addingTimeInterval(86400), streak: 3, goal: "45 sit-ups")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        completion(makeEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let entry = makeEntry()
        let nextReload = Calendar.current.date(byAdding: .minute, value: 30, to: Date()) ?? Date().addingTimeInterval(1800)
        completion(Timeline(entries: [entry], policy: .after(nextReload)))
    }

    private func makeEntry() -> SimpleEntry {
        let store = UserDefaults(suiteName: "group.k.Napha-Training-App") ?? .standard
        return SimpleEntry(
            date: Date(),
            nextWorkout: store.object(forKey: "widgetNextWorkout") as? Date,
            streak: store.integer(forKey: "widgetStreak"),
            goal: store.string(forKey: "widgetGoal") ?? "Set a NAPFA goal"
        )
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let nextWorkout: Date?
    let streak: Int
    let goal: String
}

struct nAPPfa_widgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "figure.run.circle.fill")
                    .font(.title2)
                    .foregroundStyle(.blue)
                Text("nAPPfa")
                    .font(.headline.weight(.black))
                Spacer()
            }

            HStack(alignment: .firstTextBaseline) {
                Text("\(entry.streak)")
                    .font(.system(size: 34, weight: .black, design: .rounded))
                Text(entry.streak == 1 ? "day" : "days")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)
            }

            Text(nextWorkoutText)
                .font(.caption.weight(.semibold))
                .lineLimit(2)

            Text(entry.goal)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .lineLimit(2)

            Spacer(minLength: 0)
        }
        .containerBackground(.background, for: .widget)
    }

    private var nextWorkoutText: String {
        guard let nextWorkout = entry.nextWorkout else {
            return "Schedule a workout"
        }

        let relative = relativeDayText(for: nextWorkout)
        if relative == "Today" || relative == "Now" {
            return "Workout today, \(nextWorkout.formatted(date: .omitted, time: .shortened))"
        }
        if relative == "Tomorrow" {
            return "Workout tomorrow, \(nextWorkout.formatted(date: .omitted, time: .shortened))"
        }
        return "Workout in \(relative)"
    }

    private func relativeDayText(for date: Date) -> String {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: Date())
        let end = calendar.startOfDay(for: date)
        let dayCount = calendar.dateComponents([.day], from: start, to: end).day ?? 0

        if dayCount <= 0 {
            return date <= Date() ? "Now" : "Today"
        } else if dayCount == 1 {
            return "Tomorrow"
        }
        return "\(dayCount) days"
    }
}

struct nAPPfa_widget: Widget {
    let kind: String = "nAPPfa_widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            nAPPfa_widgetEntryView(entry: entry)
        }
        .configurationDisplayName("nAPPfa")
        .description("Shows your streak, next workout, and first saved goal.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    nAPPfa_widget()
} timeline: {
    SimpleEntry(date: .now, nextWorkout: .now.addingTimeInterval(3600), streak: 4, goal: "45 sit-ups")
}
