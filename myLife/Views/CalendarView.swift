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
    
    var minYear = 2024
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button {
                        firstDayOfMonth = Calendar.current.date(byAdding: .month, value: -1, to: firstDayOfMonth)!
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.textOnBrand)
                    }
                    .disabled(firstDayOfMonth.monthInt == 1 && firstDayOfMonth.yearInt == minYear)
                    
                    Spacer()
                    
                    Text("\(firstDayOfMonth.formatted(Date.FormatStyle().month(.wide))) \(firstDayOfMonth.formatted(Date.FormatStyle().year(.defaultDigits)))")
                        .fontWeight(.black)
                        .foregroundStyle(.textOnBrand)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    Button {
                        firstDayOfMonth = Calendar.current.date(byAdding: .month, value: 1, to: firstDayOfMonth)!
                    } label: {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.textOnBrand)
                    }
                }
                .padding(.bottom)
                .padding(.horizontal)
                
                
                HStack {
                    ForEach(daysOfWeek.indices, id: \.self) { index in
                        Text(daysOfWeek[index])
                            .fontWeight(.black)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.vertical, 5)
            .foregroundStyle(.textOnBrand)
            .background(Color.brand)
            
            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self) { day in
                    Button {
                        withAnimation {
                            if (day.monthInt < firstDayOfMonth.monthInt && day.yearInt == firstDayOfMonth.yearInt) || day.yearInt < firstDayOfMonth.yearInt {
                                firstDayOfMonth = Calendar.current.date(byAdding: .month, value: -1, to: firstDayOfMonth)!
                            } else if day.monthInt > firstDayOfMonth.monthInt || day.yearInt > firstDayOfMonth.yearInt {
                                firstDayOfMonth = Calendar.current.date(byAdding: .month, value: 1, to: firstDayOfMonth)!
                            }
                            selectedDate = day
                        }
                    } label: {
                        CalendarDayView(day: day, isSelectedDate: selectedDate.startOfDay == day.startOfDay, inMonth: day.monthInt == firstDayOfMonth.monthInt)
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
