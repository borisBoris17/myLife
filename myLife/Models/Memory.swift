//
//  Memory.swift
//  myLife
//
//  Created by tucker bichsel on 1/8/25.
//

import SwiftData
import Foundation
import SwiftUI

@Model
class Memory: Codable {
    var id: UUID = UUID() // Unique identifier for each memory
    var date: Date = Date.now
    var title: String = "Title"
    var memoryText: String = "Remember this"
    var people: [Person]? = []
    var imageData: Data?
    var mood: MoodOption? = nil
    
    var unwrappedPeople: [Person] {
        people ?? []
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case title
        case memoryText
        case people
        case imageData
        case mood
    }
    
    // Initializer
    init(date: Date, title: String, memoryText: String, people: [Person], imageData: Data? = nil, mood: MoodOption? = nil) {
        self.date = date
        self.title = title
        self.memoryText = memoryText
        self.people = people
        self.imageData = imageData
        self.mood = mood
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        date = try container.decode(Date.self, forKey: .date)
        title = try container.decode(String.self, forKey: .title)
        imageData = try container.decodeIfPresent(Data.self, forKey: .imageData) ?? nil
        memoryText = try container.decode(String.self, forKey: .memoryText)
        people = try container.decode([Person].self, forKey: .people)
        mood = try container.decodeIfPresent(MoodOption.self, forKey: .mood) ?? nil
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(date, forKey: .date)
        try container.encode(title, forKey: .title)
        try container.encode(memoryText, forKey: .memoryText)
        if let imageData = imageData {
            try container.encode(imageData, forKey: .imageData)
        }
        try container.encode(people, forKey: .people)
        try container.encode(mood, forKey: .mood)
    }
    
    func getImage() -> Image? {
        guard let imageData = imageData,
              let uiImage = UIImage(data: imageData) else {
            return nil
        }
        return Image(uiImage: uiImage)
    }
    
    static let example = Memory(
        date: Date(),
        title: "Memory Title",
        memoryText: "This is a memory I have had. It was so nice and it makes me appreciate the life I have and the people in my Life.",
        people: [Person.example]
    )
}

