//
//  MemoryExporter.swift
//  myLife
//
//  Created by tucker bichsel on 3/25/25.
//

import Foundation
import SwiftData

struct MemoryExporter {
    static func exportIfNeeded(context: ModelContext) {
        let fileURL = SharedStorage.memoriesFileURL

        if FileManager.default.fileExists(atPath: fileURL.path) {
            print("✅ memories.json already exists")
            return
        }

        do {
            let fetchDescriptor = FetchDescriptor<Memory>()
            let memories = try context.fetch(fetchDescriptor)
            
            var entites: [MemoryEntity] = []
            for memory in memories {
                entites.append(MemoryEntity(id: memory.id,
                                            date: memory.date,
                                            title: memory.title,
                                            memoryText: memory.memoryText,
                                            people: []
                ))
            }

            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(entites)

            try data.write(to: fileURL)
            print("✅ Exported memories to \(fileURL.lastPathComponent)")
        } catch {
            print("❌ Failed to export memories: \(error)")
        }
    }
}
