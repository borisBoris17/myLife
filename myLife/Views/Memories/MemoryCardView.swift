//
//  MemoryCardView.swift
//  myLife
//
//  Created by tucker bichsel on 1/8/25.
//

import SwiftUI
import WrappingHStack

struct MemoryCardView: View {
    var memory: Memory
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(memory.title)
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(memory.date.formatted(date: .numeric, time: .omitted))
                }
                
                Text(memory.memoryText)
                    .multilineTextAlignment(.leading)
                
                
                GeometryReader { geometry in
                    HStack {
                        WrappingHStack(alignment: .leading) {
                            ForEach (memory.people) { person in
                                Text(person.name)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color.background)
                                    .foregroundColor(.brand)
                                    .cornerRadius(8)
                            }
                        }
                        
                        Spacer()
                        
                        
                        if let imageData = memory.imageData {
                            Image(uiImage: UIImage(data: imageData)!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                )
                        }
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
    return MemoryCardView(memory: Memory.example)
}
