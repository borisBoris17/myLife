//
//  MemoryEntry.swift
//  myLife
//
//  Created by tucker bichsel on 3/22/25.
//

import WidgetKit
import SwiftUI
import AppIntents

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
            mood: nil as MoodOption?
        )
    }
}
