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
    
    static func saveToFile(_ memory: Memory) {
        let newMemory = MemoryEntity(id: memory.id,
                                     date: memory.date,
                                     title: memory.title,
                                     memoryText: memory.memoryText,
                                     people: []
        )
        
        let fileURL = SharedStorage.memoriesFileURL
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            var existingMemories: [MemoryEntity] = []
            
            // Read existing data if the file exists
            if FileManager.default.fileExists(atPath: fileURL.path) {
                let data = try Data(contentsOf: fileURL)
                existingMemories = try decoder.decode([MemoryEntity].self, from: data)
            }
            
            // Append the new memory
            existingMemories.append(newMemory)
            
            // Encode and write the updated array back to the file
            let updatedData = try encoder.encode(existingMemories)
            try updatedData.write(to: fileURL)
            
            print("✅ Appended new memory to \(fileURL.lastPathComponent)")
        } catch {
            print("❌ Failed to append memory: \(error)")
        }
    }
    
    static func updateMemory(_ memory: Memory) {
        let updatedMemory = MemoryEntity(id: memory.id,
                                     date: memory.date,
                                     title: memory.title,
                                     memoryText: memory.memoryText,
                                     people: []
        )
        
        let fileURL = SharedStorage.memoriesFileURL
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        decoder.dateDecodingStrategy = .iso8601

        do {
            guard FileManager.default.fileExists(atPath: fileURL.path) else {
                print("❌ File does not exist")
                return
            }

            var memories = try decoder.decode([MemoryEntity].self, from: Data(contentsOf: fileURL))

            // Find and update the memory
            if let index = memories.firstIndex(where: { $0.id == updatedMemory.id }) {
                memories[index] = updatedMemory

                let updatedData = try encoder.encode(memories)
                try updatedData.write(to: fileURL)
                print("✅ Updated memory in \(fileURL.lastPathComponent)")
            } else {
                print("❌ Memory with id \(updatedMemory.id) not found")
            }
        } catch {
            print("❌ Failed to update memory: \(error)")
        }
    }
    
    static func deleteMemory(withId id: UUID) {
        let fileURL = SharedStorage.memoriesFileURL
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        decoder.dateDecodingStrategy = .iso8601

        do {
            guard FileManager.default.fileExists(atPath: fileURL.path) else {
                print("❌ File does not exist")
                return
            }

            var memories = try decoder.decode([MemoryEntity].self, from: Data(contentsOf: fileURL))

            let originalCount = memories.count
            memories.removeAll { $0.id == id }

            if memories.count == originalCount {
                print("❌ Memory with id \(id) not found")
                return
            }

            let updatedData = try encoder.encode(memories)
            try updatedData.write(to: fileURL)
            print("✅ Deleted memory from \(fileURL.lastPathComponent)")
        } catch {
            print("❌ Failed to delete memory: \(error)")
        }
    }
}
