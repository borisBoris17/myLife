//
//  Memory.swift
//  myLife
//
//  Created by tucker bichsel on 1/8/25.
//

import SwiftData
import Foundation

@Model
class Memory {
    @Attribute(.unique) var id: UUID = UUID() // Unique identifier for each memory
    var date: Date
    var title: String
    var memoryText: String
    var people: [Person] = []
    
    // Initializer
    init(date: Date, title: String, memoryText: String, people: [Person]) {
        self.date = date
        self.title = title
        self.memoryText = memoryText
        self.people = people
    }
    
    static let example = Memory(
        date: Date(),
        title: "Memory Title",
        memoryText: "This is a memory I have had. It was so nice and it makes me appreciate the life I have and the people in my Life.",
        people: [Person.example]
    )
}
