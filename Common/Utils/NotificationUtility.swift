//
//  NotificationUtility.swift
//  myLife
//
//  Created by tucker bichsel on 4/2/25.
//

import Foundation
import UserNotifications

func scheduleDetailReminderNotification() {
    let content = UNMutableNotificationContent()
    content.title = "Add some Details"
    content.body = "Ready to add details to your quick memory? Capture the full memory before it is lost."
    content.sound = .default
    
    // Target time: today at 8 PM
    var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    dateComponents.hour = 20
    dateComponents.minute = 00
    
    // Optional: if it's already past 8 PM, you might want to skip or adjust to the next day
    if let targetDate = Calendar.current.date(from: dateComponents), targetDate < Date() {
        return // or reschedule for tomorrow or an hour later
    }
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let todayKey = "memoryReminder-\(formatter.string(from: Date()))"
    
    let request = UNNotificationRequest(
        identifier: todayKey,
        content: content,
        trigger: trigger
    )
    
    
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Failed to schedule reminder: \(error)")
        }
    }
}
