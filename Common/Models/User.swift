//
//  User.swift
//  myLife
//
//  Created by tucker bichsel on 2/22/25.
//

import Foundation
import SwiftData

@Model
class User: Identifiable {
    var id: UUID = UUID()
    var streakCount: Int = 0
    var lastMomentDate: Date? = nil
    
    init(streakCount: Int, lastMomentDate: Date? = nil) {
        self.streakCount = streakCount
        self.lastMomentDate = lastMomentDate
    }
}
