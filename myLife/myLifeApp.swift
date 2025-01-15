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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Memory.self])
        }
    }
}
