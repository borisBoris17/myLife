//
//  MoodEnum.swift
//  myLife
//
//  Created by tucker bichsel on 2/25/25.
//

import Foundation

enum MoodOption: String, CaseIterable, Codable {
    case joyful = "😃"
    case funny = "😂"
    case peaceful = "☺️"
    case melancholic = "😢"
    case heartwarming = "🥰"
    case surprised = "😲"

    var emoji: String {
        return self.rawValue
    }
}
