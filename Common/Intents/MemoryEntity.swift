//
//  MemoryEntity.swift
//  myLife
//
//  Created by tucker bichsel on 3/20/25.
//

import AppIntents
import SwiftData

public struct MemoryEntity: AppEntity, Identifiable {
    public static var typeDisplayRepresentation: TypeDisplayRepresentation = "Memory"
    
    public static var defaultQuery = MemoryQuery()
    
    public var id: UUID // Unique identifier for each memory
    public var date: Date
    public var title: String
    public var memoryText: String
    public var people: [PersonEntity]
    public var imageData: Data?
    public var mood: MoodOption?

    public var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(title)", subtitle: "\(date.formatted(date: .abbreviated, time: .omitted))")
    }

    public init(
        id: UUID,
        date: Date,
        title: String,
        memoryText: String,
        people: [PersonEntity],
        imageData: Data?,
        mood: MoodOption? = nil
    ) {
        self.id = id
        self.date = date
        self.title = title
        self.memoryText = memoryText
        self.people = people
        self.imageData = imageData
        self.mood = mood
    }
}

public struct MemoryQuery: EntityQuery {
    public init() {}

    public func entities(for identifiers: [MemoryEntity.ID]) async throws -> [MemoryEntity] {
        let container = try ModelContainer(for: Memory.self)
        let context = ModelContext(container)
        
        let descriptor = FetchDescriptor<Memory>()
        let results = try context.fetch(descriptor)

        return results.map {
            MemoryEntity(id: $0.id, date: $0.date, title: $0.title, memoryText: $0.memoryText, people: [], imageData: $0.imageData)
        }
    }

    public func suggestedEntities() async throws -> [MemoryEntity] {
        let container = try ModelContainer(for: Memory.self)
        let context = ModelContext(container)

        let memories = try context.fetch(FetchDescriptor<Memory>())
        return memories.map {
            MemoryEntity(id: $0.id, date: $0.date, title: $0.title, memoryText: $0.memoryText, people: [], imageData: $0.imageData)
        }
    }
}
