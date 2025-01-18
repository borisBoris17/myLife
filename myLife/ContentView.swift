//
//  ContentView.swift
//  myLife
//
//  Created by tucker bichsel on 1/7/25.
//

import SwiftUI
import SwiftData

struct HeaderView: View {
    var body: some View {
        VStack {
            HStack {
                Image("myLifeWhiteLogo")
                    .resizable()
                    .frame(width: 100, height: 50)
                    .scaledToFit()
                
                Spacer()
                
                Image(systemName: "gearshape")
                    .font(.title)
                    .foregroundColor(Color.white)
                
                Image(systemName: "person.fill")
                    .font(.title)
                    .foregroundColor(Color.white)
                
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .background(Color.brand)
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            HeaderView()
            
            TabsView()
        }
    }
}

#Preview {
    ContentView()
}
