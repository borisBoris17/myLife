//
//  AppShortcuts.swift
//  myLife
//
//  Created by tucker bichsel on 3/18/25.
//

import AppIntents

struct MemoryShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
            AppShortcut(
                intent: QuickMemoryIntent(),
                phrases: [
                    "Remember this in \(.applicationName)",
                    "Save a memory in \(.applicationName)"
                ],
                shortTitle: "Add Memory",
                systemImageName: "text.badge.plus"
            )
    }
}
