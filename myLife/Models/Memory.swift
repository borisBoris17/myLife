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
class Memory {
    @Attribute(.unique) var id: UUID = UUID() // Unique identifier for each memory
    var date: Date
    var title: String
    var memoryText: String
    var people: [Person] = []
    var imageData: Data?
    
    // Initializer
    init(date: Date, title: String, memoryText: String, people: [Person], imageData: Data? = nil) {
        self.date = date
        self.title = title
        self.memoryText = memoryText
        self.people = people
        self.imageData = imageData
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

