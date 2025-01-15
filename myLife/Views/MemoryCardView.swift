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
