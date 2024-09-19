//
//  nAPPfa_widgetLiveActivity.swift
//  nAPPfa widget
//
//  Created by Ishaan on 14/10/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct nAPPfa_widgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct nAPPfa_widgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: nAPPfa_widgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension nAPPfa_widgetAttributes {
    fileprivate static var preview: nAPPfa_widgetAttributes {
        nAPPfa_widgetAttributes(name: "World")
    }
}

extension nAPPfa_widgetAttributes.ContentState {
    fileprivate static var smiley: nAPPfa_widgetAttributes.ContentState {
        nAPPfa_widgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: nAPPfa_widgetAttributes.ContentState {
         nAPPfa_widgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: nAPPfa_widgetAttributes.preview) {
   nAPPfa_widgetLiveActivity()
} contentStates: {
    nAPPfa_widgetAttributes.ContentState.smiley
    nAPPfa_widgetAttributes.ContentState.starEyes
}
