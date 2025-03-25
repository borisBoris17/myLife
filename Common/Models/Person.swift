//
//  Person.swift
//  myLife
//
//  Created by tucker bichsel on 1/9/25.
//

import SwiftData
import Foundation

@Model
class Person: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String = "Name"
    var gratitudes: [Gratitude]? = []
    var memories: [Memory]? = []
    
    init(name: String) {
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
    
    static let example = Person(name: "Tucker")
}
