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
    
    @Environment(\.modelContext) var modelContext
    
    
    
    @Query var memories: [Memory]
    @Query var previousMemories: [Memory]
    
    init() {
        var todayRange: Range<Date> {
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: Date())
            let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
            return startOfDay..<endOfDay
        }
        _memories = Query(
            filter: #Predicate<Memory> { memory in
                memory.date >= todayRange.lowerBound && memory.date < todayRange.upperBound
            })
        _previousMemories = Query(
            filter: #Predicate<Memory> { memory in
                memory.date < todayRange.lowerBound
            })
    }
    
    var body: some View {
        VStack {
            HeaderView()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Add Memories")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.brand)
                    
                    Spacer()
                }
                
                ScrollView {
                    ForEach (memories) { memory in
                        MemoryCardView(memory: memory)
                    }
                }
                
                Spacer()
                
                AddMemoryButtonView()
                    .onTapGesture {
                        showAddSheet = true
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
