//
//  MyLifeWidget.swift
//  MyLifeWidget
//
//  Created by tucker bichsel on 3/22/25.
//

import WidgetKit
import SwiftUI

struct RandomMemoryProvider: AppIntentTimelineProvider {
    typealias Intent = RandomMemoryIntent
    
    func placeholder(in context: Context) -> MemoryEntry {
        print("in provider placeholder")
        return MemoryEntry(date: Date(), memory: MemoryEntity.placeholder)
    }
    
    func snapshot(for configuration: RandomMemoryIntent, in context: Context) async -> MemoryEntry {
        // Try to fetch a memory using your AppIntent
        print("in provider snapshot")
        if let result = try? await configuration.perform(), let memory = result.value {
            return MemoryEntry(date: Date(), memory: memory)
        } else {
            return MemoryEntry(date: Date(), memory: MemoryEntity.placeholder)
        }
    }
    
    func timeline(for configuration: RandomMemoryIntent, in context: Context) async -> Timeline<MemoryEntry> {
        print("in provider timeline")
        if let result = try? await configuration.perform(), let memory = result.value {
            print(memory)
            let entry = MemoryEntry(date: Date(), memory: memory)
            let nextUpdate = Calendar.current.date(byAdding: .second, value: 5, to: Date())!
            let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
            return timeline
        } else {
            print("no memory")
            let entry = MemoryEntry(date: Date(), memory: MemoryEntity.placeholder)
            return Timeline(entries: [entry], policy: .atEnd)
        }
        
//        print("🚨 Timeline called directly without intent")
//
//            let entry = MemoryEntry(date: Date(), memory: MemoryEntity.placeholder)
//            return Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(10)))
    }
}

struct MemoryEntry: TimelineEntry {
    let date: Date
    let memory: MemoryEntity
}

extension MemoryEntity {
    static var placeholder: MemoryEntity {
        MemoryEntity(
            id: UUID(),
            date: Date(),
            title: "Sample Memory",
            memoryText: "A nice memory worth remembering.",
            people: [],
            imageData: nil as Data?,
            mood: nil as MoodOption?
        )
    }
}


struct MemoryWidgetEntryView: View {
    var entry: MemoryEntry
    
    var body: some View {
        HStack(spacing: 12) {
            if let data = entry.memory.imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(entry.memory.title)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(entry.memory.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .containerBackground(.background, for: .widget)
    }
}

struct MyLifeWidget: Widget {
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: "MyLifeWidget",
                            intent: RandomMemoryIntent.self,
                            provider: RandomMemoryProvider()) { entry in
            MemoryWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Random Memory")
        .description("Shows a random memory from your journal.")
        .supportedFamilies([.systemMedium]) // 4x1 is systemMedium
    }
}


@main
struct MyLifeWidgetBundle: WidgetBundle {
    var body: some Widget {
        MyLifeWidget()
    }
}
