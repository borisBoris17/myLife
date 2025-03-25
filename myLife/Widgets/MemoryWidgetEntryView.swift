//
//  MemoryWidgetEntryView.swift
//  myLife
//
//  Created by tucker bichsel on 3/22/25.
//

import SwiftUI

struct MemoryWidgetEntryView: View {
    var entry: MemoryEntry
    
    var body: some View {
        HStack(spacing: 12) {
            if let data = entry.memory.imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(entry.memory.title)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(entry.memory.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
    }
}
