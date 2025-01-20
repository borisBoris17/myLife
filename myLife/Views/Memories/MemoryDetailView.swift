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
    
    var body: some View {
        ScrollView {
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
            .frame(width: geometry.size.width, height: geometry.size.width)
            .background(Color.background)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(memory.title)
                        .font(.title)
                        .foregroundStyle(.brand)
                    
                    Spacer()
                }
                
                HStack {
                    Text(memory.date.formatted(date: .numeric, time: .omitted))
                        .foregroundStyle(.brand.opacity(0.75))
                    
                    Spacer()
                }
                    
                Text(memory.memoryText)
                    .foregroundStyle(.brand.opacity(0.75))
                    .padding(.top)
            }
            .padding()
            
            Spacer()
        }
        .background(Color.darkerBackground)
    }
}

#Preview {
    GeometryReader { geometry in
        MemoryDetailView(memory: Memory.example, geometry: geometry)
    }
}
