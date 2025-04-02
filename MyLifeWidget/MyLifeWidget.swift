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
    }
}

struct MemoryWidgetEntryView: View {
    var entry: MemoryEntry
    
    var body: some View {
        
        Link(destination: URL(string: "myLife://detail?id=\(entry.memory.id)")!) {
            
            
            HStack(spacing: 4) {
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(entry.memory.title)
                        .font(.headline)
                        .lineLimit(1)
                        .foregroundStyle(Color.textOnBrand)
                        .fontWeight(.bold)
                    
                    Text(entry.memory.memoryText)
                        .font(.caption)
                        .lineLimit(4)
                        .foregroundStyle(Color.textOnBrand)
                    
                    Spacer()
                    
                    HStack {
                        Text(entry.memory.date.formatted(date: .abbreviated, time: .omitted))
                            .font(.caption)
                            .foregroundColor(Color.textOnBrand.opacity(0.5))
                        
                        Spacer()
                        
                        Image("myLifeWhiteLogo")
                            .resizable()
                            .frame(width: 50, height: 25)
                            .scaledToFit()
                    }
                }
                
                Spacer()
            }
            .padding(5)
        }
        .widgetURL(URL(string: "myLife://detail?id=\(entry.memory.id)")!)
        .containerBackground(for: .widget) {
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: .brand, location: 0.0),
                                    .init(color: .brand, location: 0.4), // stays blue until 75%
                                    .init(color: .brand.opacity(0.5), location: 0.7),
                                    .init(color: .black, location: 1.0) // then fades to purple
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
        }
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
