//
//  RandomMemoryDetailView.swift
//  myLife
//
//  Created by tucker bichsel on 1/23/25.
//

import SwiftUI
import SwiftData

struct RandomMemoryDetailView: View {
    var memories: [Memory]
    var geometry: GeometryProxy
    @State private var randomMemory = Memory.example
    
    func updateRandomMemory() {
        if !memories.isEmpty {
            let randomIndex = Int.random(in: 0..<memories.count)
            randomMemory = memories[randomIndex]
        }
    }
    
    var body: some View {
        VStack {
            MemoryDetailView(memory: randomMemory, geometry: geometry)
        }
        .onAppear() {
            updateRandomMemory()
        }
        .toolbar {
            ToolbarItem {
                Button("Another Memory") {
                    updateRandomMemory()

                }
            }
        }
    }
}

#Preview {
    let sampleMemories = [Memory.example]
    GeometryReader { geometry in
        RandomMemoryDetailView(memories: sampleMemories, geometry: geometry)
    }
}
