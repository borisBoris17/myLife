//
//  Person.swift
//  myLife
//
//  Created by tucker bichsel on 1/9/25.
//

import SwiftData
import Foundation

@Model
class Person: Identifiable{
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    static let example = Person(name: "Tucker")
}
