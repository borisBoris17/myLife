//
//  ContentView.swift
//  myLife
//
//  Created by tucker bichsel on 1/7/25.
//

import SwiftUI
import SwiftData

struct HeaderView: View {
    
    @Environment(\.modelContext) var modelContext
    
    func forceCloudKitSync(modelContext: ModelContext) {
        do {
            try modelContext.save()
            print("Forced sync to CloudKit")
        } catch {
            print("Failed to save: \(error)")
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Image("myLifeWhiteLogo")
                    .resizable()
                    .frame(width: 100, height: 50)
                    .scaledToFit()
                
                Spacer()
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
