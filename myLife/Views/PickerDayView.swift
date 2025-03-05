//
//  PickerDayView.swift
//  myLife
//
//  Created by tucker bichsel on 3/1/25.
//

import SwiftUI
import SwiftData

struct PickerDayView: View {
    @Binding var selectedDay: Date
    var circleSize: CGFloat = 32
    var day: Date?
    var displayDay: Int
    
    @Query var memoriesForDay: [Memory]
    
    init(
        selectedDay: Binding<Date>,
        circleSize: CGFloat = 32,
        day: Date? = nil,
        displayDay: Int
    ) {
        _selectedDay = selectedDay
        self.circleSize = circleSize
        self.day = day
        self.displayDay = displayDay
        
        var dayRange: Range<Date> {
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: day!)
            let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
            return startOfDay..<endOfDay
        }
        _memoriesForDay  = Query(
            filter: #Predicate<Memory> { memory in
                memory.date >= dayRange.lowerBound && memory.date < dayRange.upperBound
            })
    }
    
    var body: some View {
        Button {
            selectedDay = day!
        } label: {
            ZStack {
                if day == selectedDay {
                    Circle()
                        .fill(Color.brand)
                }

                Circle()
                    .strokeBorder(Color.brand, lineWidth: 2)
                    .background(memoriesForDay.count > 0 ? Circle().fill(Color.textOnBrand) : nil)

                Text("\(displayDay)")
                    .font(.headline)
                    .foregroundColor(day == selectedDay ? .white : Color.brand)
            }
            .frame(width: circleSize, height: circleSize)
        }
    }
}

#Preview {
    PickerDayView(selectedDay: .constant(Date.now), circleSize: 32, day: Date.now, displayDay: 6)
}
