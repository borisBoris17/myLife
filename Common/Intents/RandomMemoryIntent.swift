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
        
        
//                print("in RandomMemoryIntent")
//        
//                let sharedURL = FileManager.default
//                    .containerURL(forSecurityApplicationGroupIdentifier: "group.com.tuckerbichsel.myLife")!
//                    .appendingPathComponent("MyLife.sqlite")
//        
//                let config = ModelConfiguration(
//                    schema: Schema([Memory.self]),
//                    url: sharedURL,
//                    cloudKitDatabase: .automatic
//                )
//        
//                let container = try ModelContainer(for: Memory.self, configurations: config)
//                let context = container.mainContext
//        
//                let fetchDescriptor = FetchDescriptor<Memory>()
//                let memories = try context.fetch(fetchDescriptor)
//        
//                print("memories count: ", memories.count)
//        
//                guard let randomMemory = memories.randomElement() else {
//                    let entity = MemoryEntity(
//                        id: Memory.example.id,
//                        date: Memory.example.date,
//                        title: "Memory.example.title",
//                        memoryText: Memory.example.memoryText,
//                        people: [],
//                        imageData: Memory.example.imageData
//                    )
//        
//                    return .result(value: entity)
//                }
//        
//                let entity = MemoryEntity(
//                    id: randomMemory.id,
//                    date: randomMemory.date,
//                    title: randomMemory.title,
//                    memoryText: randomMemory.memoryText,
//                    people: [],
//                    imageData: randomMemory.imageData
//                )
//        
//                print(entity)
//                return .result(value: entity)
    }
    
    public init() {}
}
