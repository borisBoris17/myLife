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
    @State private var randomMemory: Memory = .example
    @State private var animateStreak = false
    
    @Query var allMemories: [Memory]
    @Query var previousMemories: [Memory]
    
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var userVM: UserViewModel
    
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
        NavigationStack {
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
                        
                        VStack(spacing: 0) {
                            HStack {
                                Text("Memories")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.brand)
                                
                                Spacer()
                                
                                NavigationLink(value: allMemories) {
                                    Text("Rememeber")
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background(.brand)
                                        .foregroundColor(.textOnBrand)
                                        .cornerRadius(8)
                                }
                            }
                            
                            if (userVM.user?.streakCount ?? 0 > 0) {
                                HStack {
                                    Text("Streak: \(userVM.user?.streakCount ?? 0) \(userVM.user?.streakCount ?? 0 > 1 ? "days" : "day")")
                                        .foregroundColor(Color.brand)
                                        .fontWeight(animateStreak ? .bold : .regular)
                                        .scaleEffect(animateStreak ? 1.3 : 1.0)  // Scale effect
                                        .opacity(animateStreak ? 0.7 : 1.0)      // Opacity change
                                        .animation(.easeInOut(duration: 0.5), value: animateStreak)
                                    
                                    Spacer()
                                }
                            }
                        }
                        
                        ForEach (memories) { memory in
                            NavigationLink(value: memory) {
                                MemoryCardView(geometry: geometry, memory: memory)
                            }
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
                AddMemoryView(animateStreak: $animateStreak)
            }
            .onAppear() {
                lastDate = Date().startOfDay
            }
            .navigationDestination(for: Memory.self) { memory in
                MemoryDetailView(memory: memory, geometry: geometry)
            }
            .navigationDestination(for: [Memory].self) { memories in
                RandomMemoryDetailView(memories: memories, geometry: geometry)
            }
        }
    }
}

#Preview {
    GeometryReader { geometry in
        MemoriesView(geometry: geometry)
    }
}
