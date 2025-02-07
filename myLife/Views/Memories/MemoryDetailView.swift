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
    
    @State private var showEditMemoryView = false
    
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
                        .frame(width: geometry.size.width * 0.8)
                        .scaledToFit()
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
                        .frame(width: geometry.size.width * 0.4, height: geometry.size.width * 0.4)
                        .scaledToFit()
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
