//
//  AddMemoryButtonView.swift
//  myLife
//
//  Created by tucker bichsel on 1/8/25.
//

import SwiftUI

struct AddMemoryButtonView: View {
    var body: some View {
        VStack {
            VStack() {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(
                        Circle()
                            .foregroundColor(Color.brand)
                            .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                        
                    )
            }
        }
    }
}

#Preview {
    AddMemoryButtonView()
}
