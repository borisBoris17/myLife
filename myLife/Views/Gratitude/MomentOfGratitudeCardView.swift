//
//  MomentOfGratitudeCardView.swift
//  myLife
//
//  Created by tucker bichsel on 1/24/25.
//

import SwiftUI
import WrappingHStack

struct MomentOfGratitudeCardView: View {
    var gratitude: Gratitude
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(gratitude.text)
                    .multilineTextAlignment(.leading)
                
                GeometryReader { geometry in
                    HStack {
                        WrappingHStack(alignment: .leading) {
                            ForEach (gratitude.unwrappedPeople) { person in
                                Text(person.name)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color.background)
                                    .foregroundColor(.brand)
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.bottom)
                    }
                }
                
            }
            .padding()
            .padding(.bottom)
        }
        .foregroundStyle(Color.textOnBrand)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .foregroundColor(Color.brand)
        )
    }
}

#Preview {
    MomentOfGratitudeCardView(gratitude: Gratitude.example)
}
