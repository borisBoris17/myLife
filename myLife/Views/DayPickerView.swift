//
//  DayPickerView.swift
//  myLife
//
//  Created by tucker bichsel on 1/14/25.
//

import SwiftUI

struct DayPickerView: View {
    var geometry: GeometryProxy
    var lastDay: Date
    @Binding var selectedDay: Date
    @Binding var showCalendar: Bool
    let calendar = Calendar.current
    
    var body: some View {
        let screenWidth = geometry.size.width
        let circleCount = screenWidth > 600 ? 12 : 8 // Adjust number of circles based on screen width
        let circleSize = screenWidth / CGFloat(circleCount + 2) // Dynamically calculate circle size
        let spacing = circleCount == 8 ? circleSize / 4 : circleSize / 6
        
        
        VStack {
            HStack(spacing: spacing) {
                Button {
                    withAnimation {
                        showCalendar.toggle()
                    }
                } label: {
                    Image(systemName: showCalendar ? "xmark" : "calendar")
                        .font(.title)
                        .foregroundColor(showCalendar ? .white : Color.brand)
                        .frame(width: circleSize, height: circleSize)
                        .background(showCalendar ? Color.brand : .clear)
                        .overlay(
                            Circle()
                                .stroke(Color.brand, lineWidth: 2)
                        )
                        .clipShape(Circle())
                }
                
                ForEach((0...(circleCount - 2)).reversed(), id: \.self) { number in
                    let day = calendar.date(byAdding: .day, value: -number, to: lastDay)
                    let displayDay = calendar.component(.day, from: day ?? Date())
                    
                    PickerDayView(selectedDay: $selectedDay, circleSize: circleSize, day: day, displayDay: displayDay)
                }
            }
            .frame(width: geometry.size.width, alignment: .center)
        }
    }
}

#Preview {
    GeometryReader { geometry in
        DayPickerView(geometry: geometry, lastDay: Date(), selectedDay: .constant(Date()), showCalendar: .constant(false))
    }
}
