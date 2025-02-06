//
//  Gratitude.swift
//  myLife
//
//  Created by tucker bichsel on 1/24/25.
//

import Foundation
import SwiftData

@Model
class Gratitude {
    @Attribute(.unique) var id: UUID = UUID() // Unique identifier for each memory
    var text: String
    var people: [Person] = []
    
    init(text: String, people: [Person]) {
        self.text = text
        self.people = people
    }
    
    static let example = Gratitude(text: "They took the time out of their day to do something nice for me and it made me feel good about myself.", people: [Person.example])
}
