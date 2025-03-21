//
//  QuickMemoryAddIntent.swift
//  myLife
//
//  Created by tucker bichsel on 3/16/25.
//
import AppIntents
import SwiftUI
import SwiftData

struct QuickMemoryIntent: AppIntent {
    static var title: LocalizedStringResource = "Add Memory"
    static var description = IntentDescription("Capture a quick memory note.")

    @Parameter(title: "Memory Text", requestValueDialog: "What do you want to remember?")
    var text: String

    static var parameterSummary: some ParameterSummary {
        Summary("Remember \(\.$text)")
    }

    @MainActor
    func perform() async throws -> some ProvidesDialog & IntentResult {
        
        do {
            let modelContainer = try ModelContainer(for: Memory.self)
            let modelContext = modelContainer.mainContext
            
            // Insert the new task
            let newMemory = Memory(title: text)
            modelContext.insert(newMemory)
            
            // Save the context to persist data
            try modelContext.save()
            
            return .result(dialog: "Memory Added: \(text)")
        } catch {
            return .result(dialog: "Failed to add task: \(error.localizedDescription)")
        }
    }
}
