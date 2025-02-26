//
//  TabsView.swift
//  myLife
//
//  Created by tucker bichsel on 1/17/25.
//

import SwiftUI

struct TabsView: View {
    @State var selection: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            TabView(selection: $selection) {
                MemoriesView(geometry: geometry)
                    .tabItem {
                        Label("Memories", systemImage: "brain.fill")
                    }
                    .tag(0)
                
                GratitudeView(geometry: geometry)
                    .tabItem {
                        Label("Gratitude", systemImage: "sparkles")
                    }
                    .tag(1)
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
                    .tag(2)
            }
            .tint(.brand)
        }
    }
}

#Preview {
    TabsView()
}
