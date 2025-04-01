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
    
    public var id: UUID
    public var date: Date
    public var title: String
    public var memoryText: String
    public var people: [PersonEntity]
    public var mood: MoodOption?

    public var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: "\(title)",
            subtitle: "\(date.formatted(date: .abbreviated, time: .omitted))"
        )
    }

    public init(
        id: UUID,
        date: Date,
        title: String,
        memoryText: String,
        people: [PersonEntity],
        mood: MoodOption? = nil
    ) {
        self.id = id
        self.date = date
        self.title = title
        self.memoryText = memoryText
        self.people = people
        self.mood = mood
    }
}

extension MemoryEntity: Codable {
    enum CodingKeys: String, CodingKey {
        case id, date, title, memoryText, people, mood
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(date, forKey: .date)
        try container.encode(title, forKey: .title)
        try container.encode(memoryText, forKey: .memoryText)
        try container.encode(people, forKey: .people)
        try container.encode(mood, forKey: .mood)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        date = try container.decode(Date.self, forKey: .date)
        title = try container.decode(String.self, forKey: .title)
        memoryText = try container.decode(String.self, forKey: .memoryText)
        people = try container.decode([PersonEntity].self, forKey: .people)
        mood = try container.decodeIfPresent(MoodOption.self, forKey: .mood)
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
            MemoryEntity(id: $0.id, date: $0.date, title: $0.title, memoryText: $0.memoryText, people: [])
        }
    }

    public func suggestedEntities() async throws -> [MemoryEntity] {
        let container = try ModelContainer(for: Memory.self)
        let context = ModelContext(container)

        let memories = try context.fetch(FetchDescriptor<Memory>())
        return memories.map {
            MemoryEntity(id: $0.id, date: $0.date, title: $0.title, memoryText: $0.memoryText, people: [])
        }
    }
}
