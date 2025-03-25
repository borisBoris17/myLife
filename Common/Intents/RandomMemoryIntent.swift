//
//  RandomMemoryIntent.swift
//  myLife
//
//  Created by tucker bichsel on 3/20/25.
//

import AppIntents
import SwiftUI
import SwiftData

public struct RandomMemoryIntent: AppIntent, WidgetConfigurationIntent {
    public static var title: LocalizedStringResource { "Random Memory" }
    public static var description = IntentDescription("Get a random memory to jog your memory!")
    
    @MainActor
    public func perform() async throws -> some IntentResult & ProvidesDialog & ReturnsValue<MemoryEntity> {
        print("in RandomMemoryIntent")
        
        let modelContainer = try ModelContainer(for: Memory.self)
        let modelContext = modelContainer.mainContext
        
        let fetchDescriptor = FetchDescriptor<Memory>()
        let memories = try modelContext.fetch(fetchDescriptor)
        
        print("memories count: ", memories.count)
        
        guard let randomMemory = memories.randomElement() else {
            let entity = MemoryEntity(
                id: Memory.example.id,
                date: Memory.example.date,
                title: "Memory.example.title",
                memoryText: Memory.example.memoryText,
                people: [],
                imageData: Memory.example.imageData
            )
            
            return .result(value: entity,
                           dialog: "returning entity \(entity.title)")
        }
        
        let entity = MemoryEntity(
            id: randomMemory.id,
            date: randomMemory.date,
            title: randomMemory.title,
            memoryText: randomMemory.memoryText,
            people: [],
            imageData: randomMemory.imageData
        )
        
        print(entity)
        return .result(value: entity,
                       dialog: "returning entity \(entity.title)")
    }

    public init() {}
}
