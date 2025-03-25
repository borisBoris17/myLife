//
//  RandomMemoryProvider.swift
//  myLife
//
//  Created by tucker bichsel on 3/22/25.
//

import Foundation
import WidgetKit

//struct RandomMemoryProvider: AppIntentTimelineProvider {
//    typealias Intent = RandomMemoryIntent
//    
//    func placeholder(in context: Context) -> MemoryEntry {
//        MemoryEntry(date: Date(), memory: MemoryEntity.placeholder)
//    }
//    
//    func snapshot(for configuration: RandomMemoryIntent, in context: Context) async -> MemoryEntry {
//        // Try to fetch a memory using your AppIntent
//        if let result = try? await configuration.perform(), let memory = result.value {
//            return MemoryEntry(date: Date(), memory: memory)
//        } else {
//            return MemoryEntry(date: Date(), memory: MemoryEntity.placeholder)
//        }
//    }
//    
//    func timeline(for configuration: RandomMemoryIntent, in context: Context) async -> Timeline<MemoryEntry> {
////        if let result = try? await configuration.perform(), let memory = result.value {
////            let entry = MemoryEntry(date: Date(), memory: memory)
////            let timeline = Timeline(entries: [entry], policy: .atEnd)
////            return timeline
////        } else {
////            let entry = MemoryEntry(date: Date(), memory: MemoryEntity.placeholder)
////            return Timeline(entries: [entry], policy: .atEnd)
////        }
//        print("🚨 Timeline called directly without intent")
//
//            let entry = MemoryEntry(date: Date(), memory: MemoryEntity.placeholder)
//            return Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(10)))
//    }
//}
