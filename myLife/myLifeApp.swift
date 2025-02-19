//
//  myLifeApp.swift
//  myLife
//
//  Created by tucker bichsel on 1/7/25.
//

import SwiftUI
import SwiftData

@main
struct myLifeApp: App {
    var sharedModelContainer: ModelContainer = {
        let config = ModelConfiguration(cloudKitDatabase: .automatic)
        
        do {
            return try ModelContainer(for: Memory.self, Gratitude.self, Person.self, configurations: config)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(sharedModelContainer)
        }
    }
}
