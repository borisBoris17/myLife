//
//  PeopleEntity.swift
//  myLife
//
//  Created by tucker bichsel on 3/20/25.
//
import AppIntents
import SwiftData


public struct PersonEntity: AppEntity, Identifiable {
    public var id: UUID
    public var name: String
    
    public static var typeDisplayRepresentation: TypeDisplayRepresentation = "Person"
    public static var defaultQuery = PersonQuery()
    
    public var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(name)", subtitle: "\(name)")
    }
    
    public init(id: UUID = UUID(), name: String = "Name") {
        self.id = id
        self.name = name
    }
}

extension PersonEntity: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
}

public struct PersonQuery: EntityQuery {
    public init() {}
    
    public func entities(for identifiers: [PersonEntity.ID]) async throws -> [PersonEntity] {
        let container = try ModelContainer(for: Memory.self) // Might be a mistake here, see note below
        let context = ModelContext(container)
        
        let descriptor = FetchDescriptor<Person>()
        let results = try context.fetch(descriptor)
        
        return results.map {
            PersonEntity(id: $0.id, name: $0.name)
        }
    }
    
    public func suggestedEntities() async throws -> [PersonEntity] {
        let container = try ModelContainer(for: Person.self)
        let context = ModelContext(container)
        
        let people = try context.fetch(FetchDescriptor<Person>())
        return people.map {
            PersonEntity(id: $0.id, name: $0.name)
        }
    }
}
