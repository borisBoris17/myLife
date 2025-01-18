//
//  CalendarDayView.swift
//  myLife
//
//  Created by tucker bichsel on 1/15/25.
//

import SwiftUI
import SwiftData

struct CalendarDayView: View {
    var day: Date
    var isSelectedDate: Bool
    var inMonth: Bool
    
    // Query for finding any Memories for this day
    @Query var memoriesForDay: [Memory]
    
    init(day: Date, isSelectedDate: Bool, inMonth: Bool) {
        self.day = day
        self.isSelectedDate = isSelectedDate
        self.inMonth = inMonth
        
        var dayRange: Range<Date> {
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: day)
            let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
            return startOfDay..<endOfDay
        }
        _memoriesForDay = Query(
            filter: #Predicate<Memory> { memory in
                memory.date >= dayRange.lowerBound && memory.date < dayRange.upperBound
            })
    }
    
    var body: some View {
        VStack {
            Text(day.formatted(.dateTime.day()))
                .fontWeight(.bold)
                .foregroundStyle(isSelectedDate
                                 ? Color.textOnBrand
                                 : inMonth ? Color.brand : Color.brand.opacity(0.5))
                .frame(maxWidth: .infinity, minHeight: 35)
                .background(
                    Circle()
                        .foregroundStyle(
                            isSelectedDate
                            ? .brand
                            : .clear
                        )
                )
                .padding(.bottom, 5)
            
            Image(systemName: "circle.fill")
                .foregroundStyle(memoriesForDay.count > 0 ? Color.brand : .clear)
                .font(.system(size: 8))
        }
    }
}

#Preview {
    CalendarDayView(day: Date(), isSelectedDate: true, inMonth: true)
}
