//
//  MemoryCardView.swift
//  myLife
//
//  Created by tucker bichsel on 1/8/25.
//

import SwiftUI
import WrappingHStack

struct MemoryCardView: View {
    var geometry: GeometryProxy
    
    var memory: Memory
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                
                if let imageData = memory.imageData, let uiImage = UIImage(data: imageData) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(memory.title)
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                            
                            Text(memory.date.formatted(date: .numeric, time: .omitted))
                                .font(.caption)
                                .padding(.bottom, 5)
                            
                            Text(memory.memoryText)
                                .multilineTextAlignment(.leading)
                            
                            HStack {
                                WrappingHStack(alignment: .leading) {
                                    ForEach (memory.unwrappedPeople) { person in
                                        Text(person.name)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 8)
                                            .background(Color.background)
                                            .foregroundColor(.brand)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                        }
                        
                        VStack {
                            Image(uiImage: uiImage)
                                .resizable()
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                )
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.35)
                            
                            Spacer()
                        }
                    }
                } else {
                    HStack {
                        Text(memory.title)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        
                        Text(memory.date.formatted(date: .numeric, time: .omitted))
                    }
                    
                    Text(memory.memoryText)
                        .multilineTextAlignment(.leading)
                    
                    HStack {
                        WrappingHStack(alignment: .leading) {
                            ForEach (memory.unwrappedPeople) { person in
                                Text(person.name)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color.background)
                                    .foregroundColor(.brand)
                                    .cornerRadius(8)
                            }
                        }
                        
                        Spacer()
                    }
                }
            }
            .padding()
        }
        .foregroundStyle(Color.textOnBrand)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .foregroundColor(Color.brand)
        )
    }
}

#Preview {
    GeometryReader { geometry in
        return MemoryCardView(geometry: geometry, memory: Memory.example)
    }
}
