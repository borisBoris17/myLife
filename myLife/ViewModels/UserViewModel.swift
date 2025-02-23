//
//  UserViewModel.swift
//  myLife
//
//  Created by tucker bichsel on 2/22/25.
//

import SwiftData
import SwiftUI

@MainActor
class UserViewModel: ObservableObject {
    @Published var user: User?

    let context: ModelContext

    init(context: ModelContext) {
        self.context = context
        fetchOrCreateUser()
    }

    private func fetchOrCreateUser() {
        let descriptor = FetchDescriptor<User>()
        
        if let existingUser = try? context.fetch(descriptor).first {
            self.user = existingUser
        } else {
            // No user found, create a new one
            let newUser = User(streakCount: 0, lastMomentDate: nil)
            context.insert(newUser)
            try? context.save()
            self.user = newUser
        }
    }

    func updateStreak() {
        guard let user else { return }
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        if let lastDate = user.lastMomentDate {
            let dayDifference = calendar.dateComponents([.day], from: lastDate, to: today).day ?? 0
            
            if dayDifference == 1 {
                user.streakCount += 1
            } else if dayDifference > 1 {
                user.streakCount = 1
            }
        } else {
            user.streakCount = 1 // First entry
        }

        user.lastMomentDate = today
        try? context.save()
    }
    
    func setStreak(to newValue: Int, latestDate: Date) {
        guard let user else { return }
        user.streakCount = newValue
        user.lastMomentDate = latestDate
        try? context.save()
    }
}
