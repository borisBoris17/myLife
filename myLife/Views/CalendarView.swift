//
//  CalendarView.swift
//  myLife
//
//  Created by tucker bichsel on 1/15/25.
//

import SwiftUI

struct CalendarView: View {
    @State private var firstDayOfMonth = Date().startOfMonth
    @State private var days: [Date] = []
    @Binding var selectedDate: Date
    
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var minYear = 2025
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    firstDayOfMonth = Calendar.current.date(byAdding: .month, value: -1, to: firstDayOfMonth)!
                } label: {
                    Image(systemName: "chevron.left")
                }
                .disabled(firstDayOfMonth.monthInt == 1 && firstDayOfMonth.yearInt == minYear)
                
                Spacer()
                
                Text("\(firstDayOfMonth.formatted(Date.FormatStyle().month(.wide))) \(firstDayOfMonth.formatted(Date.FormatStyle().year(.defaultDigits)))")
                    .fontWeight(.black)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity)
                
                Spacer()
                
                Button {
                    firstDayOfMonth = Calendar.current.date(byAdding: .month, value: 1, to: firstDayOfMonth)!
                } label: {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.bottom)
            .padding(.horizontal)

            
            HStack {
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    Text(daysOfWeek[index])
                        .fontWeight(.black)
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity)
                }
            }
            
            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self) { day in
                    if day.monthInt != firstDayOfMonth.monthInt {
                        Text("")
                    } else {
                        Button {
                            withAnimation {
                                selectedDate = day
                            }
                        } label: {
                            CalendarDayView(day: day, isSelectedDate: selectedDate.startOfDay == day.startOfDay)
                        }
                    }
                }
            }
        }
        .onAppear {
            days = firstDayOfMonth.calendarDisplayDays
        }
        .onChange(of: firstDayOfMonth) {
            days = firstDayOfMonth.calendarDisplayDays
        }
    }
}


#Preview {
    CalendarView(selectedDate: .constant(Date()))
}
