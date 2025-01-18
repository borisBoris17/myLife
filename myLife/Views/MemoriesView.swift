//
//  MemoriesView.swift
//  myLife
//
//  Created by tucker bichsel on 1/17/25.
//

import SwiftUI
import SwiftData

struct MemoriesView: View {
    var geometry: GeometryProxy
    
    @State private var showAddSheet = false
    @State private var selectedDate = Date().startOfDay
    @State private var lastDate = Date().startOfDay
    @State private var showCalendar = false
    
    @Query var allMemories: [Memory]
    @Query var previousMemories: [Memory]
    
    @Environment(\.modelContext) var modelContext
    
    private var memories: [Memory] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: selectedDate)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        return allMemories.filter { memory in
            memory.date >= startOfDay && memory.date < endOfDay
        }
    }
    
    init(geometry: GeometryProxy) {
        self.geometry = geometry
        var todayRange: Range<Date> {
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: Date())
            let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
            return startOfDay..<endOfDay
        }
        _previousMemories = Query(
            filter: #Predicate<Memory> { memory in
                memory.date < todayRange.lowerBound
            })
    }
    
    var body: some View {
        VStack {
            DayPickerView(geometry: geometry, lastDay: lastDate, selectedDay: $selectedDate, showCalendar: $showCalendar)
            
            ScrollView {
                
                if showCalendar {
                    CalendarView(selectedDate: $selectedDate)
                        .padding(.bottom)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal, 1)
                }
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("Memories")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.brand)
                        
                        Spacer()
                        
                        Button {
                            print("Take them to a random memory detail screen.")
                        } label: {
                            Text("Rememeber")
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(.brand)
                                .foregroundColor(.textOnBrand)
                                .cornerRadius(8)
                        }
                    }
                    
                    
                    ForEach (memories) { memory in
                        MemoryCardView(memory: memory)
                    }
                    
                    Spacer()
                    
                }
                
            }
            .scrollIndicators(.hidden)
            .safeAreaInset(edge: .bottom) {
                HStack {
                    Spacer()
                    
                    AddMemoryButtonView()
                        .onTapGesture {
                            showAddSheet = true
                        }
                        .padding()
                }
                
            }
            .padding(.horizontal)
        }
        .padding(.top, 5)
        .background(Color.background)
        .sheet(isPresented: $showAddSheet) {
            AddMemoryView()
        }
        .onAppear() {
            if previousMemories.isEmpty {
                let newMemory = Memory(date: Date(), title: "Special Memory", memoryText: "This is a special memory. I really enjoyed what happened today. It made me laugh a lot.", people: [])
                modelContext.insert(newMemory) // Add the memory to the SwiftData context
                try? modelContext.save()
            }
        }
    }
}

#Preview {
    GeometryReader { geometry in
        MemoriesView(geometry: geometry)
    }
}
