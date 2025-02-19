//
//  Gratitude.swift
//  myLife
//
//  Created by tucker bichsel on 1/24/25.
//

import Foundation
import SwiftData

@Model
class Gratitude: Codable {
    var id: UUID = UUID() // Unique identifier for each memory
    var text: String = "Thank you"
    var people: [Person]? = []
    
    var unwrappedPeople: [Person] {
        people ?? []
    }
    
    init(text: String, people: [Person]) {
        self.text = text
        self.people = people
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case people
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        text = try container.decode(String.self, forKey: .text)
        people = try container.decode([Person].self, forKey: .people)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(text, forKey: .text)
        try container.encode(people, forKey: .people)
    }
    
    static let example = Gratitude(text: "They took the time out of their day to do something nice for me and it made me feel good about myself.", people: [Person.example])
}
