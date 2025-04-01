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
    public func perform() async throws -> some IntentResult & ReturnsValue<MemoryEntity> {
        let url = SharedStorage.memoriesFileURL
        
        do {            
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let memories = try decoder.decode([Memory].self, from: data)
            
            for memory in memories {
                print("📖 \(memory.title)")
            }
            
            if let randomMemory = memories.randomElement() {
                let entity = MemoryEntity(id: randomMemory.id,
                                          date: randomMemory.date,
                                          title: randomMemory.title,
                                          memoryText: randomMemory.memoryText,
                                          people: [])

                return .result(value: entity)
            } else {
                return .result(value: MemoryEntity.placeholder)
            }
        } catch {
            print("❌ Failed to read memories from file: \(error)")
            return .result(value: MemoryEntity.placeholder)
        }
    }
    
    public init() {}
}
