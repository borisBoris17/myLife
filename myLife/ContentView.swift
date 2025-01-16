//
//  ContentView.swift
//  myLife
//
//  Created by tucker bichsel on 1/7/25.
//

import SwiftUI
import SwiftData

struct HeaderView: View {
    var body: some View {
        VStack {
            HStack {
                Image("myLifeWhiteLogo")
                    .resizable()
                    .frame(width: 100, height: 50)
                    .scaledToFit()
                
                Spacer()
                
                Image(systemName: "gearshape")
                    .font(.title)
                    .foregroundColor(Color.white)
                
                Image(systemName: "person.fill")
                    .font(.title)
                    .foregroundColor(Color.white)
                
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .background(Color.brand)
    }
}

struct ContentView: View {
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
    
    init() {
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
        GeometryReader { geometry in
            VStack {
                HeaderView()
                
                DayPickerView(geometry: geometry, lastDay: lastDate, selectedDay: $selectedDate, showCalendar: $showCalendar)
//                    .padding(.top, 2)
                
                ScrollView {
                    
                    if showCalendar {
                        CalendarView(selectedDate: $selectedDate)
                            .padding(.vertical)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(.white)
                            )
                            .padding(.horizontal, 1)
                    }
                    
                    VStack(alignment: .leading) {
                        
                        HStack {
                            Text("Memories")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.brand)
                            
                            Spacer()
                        }
                        
                        
                        ForEach (memories) { memory in
                            MemoryCardView(memory: memory)
                        }
                        
                        Spacer()
                        
                    }
                    
                }
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
                
                Spacer()
                
                VStack(alignment: .leading) {
                    if let randomMemory = previousMemories.randomElement() {
                        HStack {
                            Text("Remember")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.brand)
                            
                            Spacer()
                        }
                        
                        MemoryCardView(memory: randomMemory)
                    }
                }
                .padding(.horizontal)
            }
        }
        .sheet(isPresented: $showAddSheet) {
            AddMemoryView()
        }
        .background(Color.background)
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
    ContentView()
}
