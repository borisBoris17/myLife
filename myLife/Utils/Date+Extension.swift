//
//  Date+Extension.swift
//  myLife
//
//  Created by tucker bichsel on 1/15/25.
//

import Foundation

extension Date {
    static var firstDayOfWeek = Calendar.current.firstWeekday
    static var capitalizedFirstLettersOfWeekdays: [String] {
        let calendar = Calendar.current
        // Adjusted for the different weekday starts
        var weekdays = calendar.shortWeekdaySymbols
        if firstDayOfWeek > 1 {
            for _ in 1..<firstDayOfWeek {
                if let first = weekdays.first {
                    weekdays.append(first)
                    weekdays.removeFirst()
                }
            }
        }
        return weekdays.map { $0.capitalized }
    }
    
    static var fullMonthNames: [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        
        return (1...12).compactMap { month in
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
            let date = Calendar.current.date(from: DateComponents(year: 2000, month: month, day: 1))
            return date.map { dateFormatter.string(from: $0) }
        }
    }
    
    var startOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }
    
    var endOfMonth: Date {
        let lastDay = Calendar.current.dateInterval(of: .month, for: self)!.end
        return Calendar.current.date(byAdding: .day, value: -1, to: lastDay)!
    }
    
    var startOfPreviousMonth: Date {
        let dayInPreviousMonth = Calendar.current.date(byAdding: .month, value: -1, to: self)!
        return dayInPreviousMonth.startOfMonth
    }
    
    var startOfNextMonth: Date {
        let dayInNextMonth = Calendar.current.date(byAdding: .month, value: 1, to: self)!
        return dayInNextMonth.startOfMonth
    }
    
    var numberOfDaysInMonth: Int {
        Calendar.current.component(.day, from: endOfMonth)
    }
    
    // Fix: negative days causing issue for first row
    var firstWeekDayBeforeStart: Date {
        let startOfMonthWeekday = Calendar.current.component(.weekday, from: startOfMonth)
        var numberFromPreviousMonth = startOfMonthWeekday - Self.firstDayOfWeek
        if numberFromPreviousMonth < 0 {
            numberFromPreviousMonth += 7 // Adjust to a 0-6 range if negative
        }
        return Calendar.current.date(byAdding: .day, value: -numberFromPreviousMonth, to: startOfMonth)!
    }
    
    var calendarDisplayDays: [Date] {
        var days: [Date] = []
        // Start with days from the previous month to fill the grid
        let firstDisplayDay = firstWeekDayBeforeStart
        var day = firstDisplayDay
        while day < startOfMonth {
            days.append(day)
            day = Calendar.current.date(byAdding: .day, value: 1, to: day)!
        }
        // Add days of the current month
        for dayOffset in 0..<numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfMonth)
            days.append(newDay!)
        }
        // Add days until the end of the current week
        var lastDayAdded = days[days.count - 1]
        let lastDisplayDay = Calendar.current.date(byAdding: .day, value: daysUntilEndOfWeek(from: lastDayAdded), to: lastDayAdded)!
        while lastDayAdded < lastDisplayDay {
            lastDayAdded = Calendar.current.date(byAdding: .day, value: 1, to: lastDayAdded)!
            days.append(lastDayAdded)
        }
        return days
    }
    
    func daysUntilEndOfWeek(from date: Date) -> Int {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        
        // In the Gregorian calendar, Sunday is 1 and Saturday is 7.
        // So we calculate how many days are left to reach Sunday.
        let daysUntilSunday = 7 - weekday
        
        return daysUntilSunday
    }
    
    var yearInt: Int {
        Calendar.current.component(.year, from: self)
    }
    
    
    var monthInt: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var dayInt: Int {
        Calendar.current.component(.day, from: self)
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        Calendar.current.date(byAdding: .second, value: -1, to: Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!)!
    }
    
    // Used to generate the mock data for previews
    // Computed property courtesy of ChatGPT
    var randomDateWithinLastThreeMonths: Date {
        let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: self)!
        let randomTimeInterval = TimeInterval.random(in: 0.0..<self.timeIntervalSince(threeMonthsAgo))
        let randomDate = threeMonthsAgo.addingTimeInterval(randomTimeInterval)
        return randomDate
    }
    
    var isFridaySaturday: Bool {
        let dayOfWeek = self.formatted(Date.FormatStyle().weekday(.oneDigit))
        return dayOfWeek == "6" || dayOfWeek == "7"
    }
    
    var numericFormattedDate: String {
        self.formatted(date: .numeric, time: .omitted)
    }
    
    func daysUntil(date: Date) -> Int {
        let currentCalendar = Calendar.current

        guard let start = currentCalendar.ordinality(of: .day, in: .era, for: self) else { return 0 }
        guard let end = currentCalendar.ordinality(of: .day, in: .era, for: date) else { return 0 }

        return end - start
    }
}
