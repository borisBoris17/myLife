//
//  MemoryDetailView.swift
//  myLife
//
//  Created by tucker bichsel on 1/19/25.
//

import SwiftUI

struct MemoryDetailView: View {
    var memory: Memory
    var geometry: GeometryProxy
    var updateMemory: () -> Void = { }
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var showEditMemoryView = false
    @State private var showDeleteConfirmation: Bool = false
    
    func deleteMemory(memory: Memory) {
        modelContext.delete(memory)
        
        try? modelContext.save()
    }
    
    var body: some View {
        ScrollView {
            
            HStack {
                Text(memory.title)
                    .font(.title)
                    .foregroundStyle(.brand)
                    .fontWeight(.bold)
            }
            
            VStack {
                
                if let image = memory.getImage() {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.8)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                        )
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .foregroundColor(Color.darkerBackground)
                        )
                } else {
                    Image(systemName: "camera")
                        .resizable()
                        .foregroundStyle(.brand.opacity(0.5))
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.4, height: geometry.size.width * 0.4)
                        .padding(50)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .foregroundColor(Color.darkerBackground)
                        )
                }
            }
            .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.width)
            
            VStack(alignment: .leading) {
                
                HStack {
                    if let mood = memory.mood {
                        Text("\(mood.rawValue) \(mood.name)")
                            .foregroundStyle(.brand.opacity(0.75))
                            .font(.title3)
                    }
                    
                    Spacer()
                    
                    Text(memory.date.formatted(date: .numeric, time: .omitted))
                        .foregroundStyle(.brand.opacity(0.75))
                }
                
                Text(memory.memoryText)
                    .foregroundStyle(.brand.opacity(0.75))
                    .padding(.top)
                
                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundColor(Color.darkerBackground)
            )
            .padding()
            
            HStack {
                Spacer()
                
                Button("Delete", role: .destructive) {
                    showDeleteConfirmation = true
                }
                .alert(isPresented: $showDeleteConfirmation) {
                    Alert(title: Text("Delete Memory"), message: Text("Are you sure you want to delete this memory?"), primaryButton: .destructive(Text("Delete")) {
                        deleteMemory(memory: memory)
                        dismiss()
                    }, secondaryButton: .cancel())
                }
            }
            .padding(.horizontal)
        }
        //        .background(Color.darkerBackground)
        .background(Color.background)
        .toolbar {
            ToolbarItem {
                Button("Edit") {
                    showEditMemoryView.toggle()
                }
            }
        }
        .sheet(isPresented: $showEditMemoryView) {
            EditMemoryView(memory: memory)
        }
    }
}

#Preview {
    GeometryReader { geometry in
        MemoryDetailView(memory: Memory.example, geometry: geometry)
    }
}
