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
                HStack {
                    Spacer()
                    
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(Color.white)
                    
                    Spacer()
                }
            }
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .foregroundColor(Color.brand)
        )
    }
}

#Preview {
    AddMemoryButtonView()
}
