//
//  SharedStorage.swift
//  myLife
//
//  Created by tucker bichsel on 3/25/25.
//

import Foundation

struct SharedStorage {
    static let appGroupID = "group.com.tuckerbichsel.myLife"

    static var memoriesFileURL: URL {
        FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: appGroupID)!
            .appendingPathComponent("memories.json")
    }
    
    static var sharedMemory: UserDefaults? {
        UserDefaults(suiteName: "group.com.tuckerbichsel.myLife")
    }
}
