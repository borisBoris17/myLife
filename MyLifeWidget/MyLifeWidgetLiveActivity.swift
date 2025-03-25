//
//  MyLifeWidgetLiveActivity.swift
//  MyLifeWidget
//
//  Created by tucker bichsel on 3/22/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct MyLifeWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct MyLifeWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MyLifeWidgetAttributes.self) { context in
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

extension MyLifeWidgetAttributes {
    fileprivate static var preview: MyLifeWidgetAttributes {
        MyLifeWidgetAttributes(name: "World")
    }
}

extension MyLifeWidgetAttributes.ContentState {
    fileprivate static var smiley: MyLifeWidgetAttributes.ContentState {
        MyLifeWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: MyLifeWidgetAttributes.ContentState {
         MyLifeWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: MyLifeWidgetAttributes.preview) {
   MyLifeWidgetLiveActivity()
} contentStates: {
    MyLifeWidgetAttributes.ContentState.smiley
    MyLifeWidgetAttributes.ContentState.starEyes
}
