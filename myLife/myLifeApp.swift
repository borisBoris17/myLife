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
        guard let sharedURL = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.com.tuckerbichsel.myLife")?
            .appendingPathComponent("MyLife.sqlite") else {
            fatalError("Failed to find shared app group container.")
        }
        
        let config = ModelConfiguration(
//            schema: Schema([Memory.self, Gratitude.self, Person.self, User.self]),
//            url: sharedURL,
            cloudKitDatabase: .automatic
        )
        
        do {
            return try ModelContainer(
                for: Memory.self, Gratitude.self, Person.self, User.self,
                configurations: config
            )
        } catch {
            fatalError("❌ Failed to create shared ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(sharedModelContainer)
        }
    }
}
