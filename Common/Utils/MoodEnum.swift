//
//  MoodEnum.swift
//  myLife
//
//  Created by tucker bichsel on 2/25/25.
//

import Foundation

public enum MoodOption: String, CaseIterable, Codable {
    case joyful = "😃"
    case funny = "😂"
    case peaceful = "☺️"
    case melancholic = "😢"
    case heartwarming = "🥰"
    case surprised = "😲"
    
    var name: String {
        switch self {
        case .joyful: return "Joyful"
        case .funny: return "Funny"
        case .peaceful: return "Peaceful"
        case .melancholic: return "Melancholic"
        case .heartwarming: return "Heartwarming"
        case .surprised: return "Surprised"
        }
    }
    
    var emoji: String {
        return self.rawValue
    }
}
