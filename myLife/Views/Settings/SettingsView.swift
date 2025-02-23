//
//  SettingsView.swift
//  myLife
//
//  Created by tucker bichsel on 2/22/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userVM: UserViewModel
    @State private var tempStreak: Int
    
    init() {
        // Initialize tempStreak with the current streak from userVM
        _tempStreak = State(initialValue: 0)
    }
    
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
                    
                    NavigationLink(destination: SetStreakView()) {
                        HStack {
                            Image(systemName: "flame")
                                .foregroundColor(Color.textOnBrand)
                            
                            Text("Set Streak")
                                .foregroundColor(Color.textOnBrand)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color.textOnBrand)
                        }
                        .padding()
                        .background(Color.brand)
                    }
                }
                
                Spacer()
            }
            .onAppear {
                tempStreak = userVM.user?.streakCount ?? 0
            }
            .background(Color.background)
        }
    }
}

#Preview {
    SettingsView()
}
