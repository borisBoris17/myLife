//
//  SettingsView.swift
//  myLife
//
//  Created by tucker bichsel on 2/22/25.
//

import SwiftUI

struct SettingsView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Settings")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.brand)
                        .padding()
                    
                }
                
                VStack {
                    HStack {
                        Text("User Settings")
                            .font(.title3)
                            .foregroundColor(Color.brand)
                        
                        Spacer()
                    }
                
                }
                
                Spacer()
            }
            .background(Color.background)
        }
    }
}

#Preview {
    SettingsView()
}
