//
//  SetStreakView.swift
//  myLife
//
//  Created by tucker bichsel on 2/22/25.
//

import SwiftUI

struct SetStreakView: View {
    @EnvironmentObject var userVM: UserViewModel
    @State private var newStreak: String
    @State private var newLatestDate: Date
    
    @Environment(\.dismiss) private var dismiss
    
    init() {
        _newStreak = State(initialValue: "") // Initialize as empty, will update onAppear
        _newLatestDate = State(initialValue: Date())
    }
    
    var body: some View {
        VStack {
            ScrollView {
                Text("Set Streak")
                    .font(.title)
                    .foregroundColor(Color.brand)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Enter New Streak Count")
                        .font(.headline)
                        .foregroundColor(Color.brand)
                    
                    TextField("Streak Count", text: $newStreak)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.brand.opacity(0.8), lineWidth: 1)
                        )
                        .foregroundColor(.brand)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.vertical)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Select Latest Date")
                        .font(.headline)
                        .foregroundColor(Color.brand)
                    
                    DatePicker("Latest Entry Date", selection: $newLatestDate, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(.graphical) // Use a nice graphical date picker
                        .accentColor(.textOnBrand)
                        .background(Color.brand.opacity(0.6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.vertical)
                
                Button("Save Streak") {
                    if let streakValue = Int(newStreak), streakValue >= 0 {
                        userVM.setStreak(to: streakValue, latestDate: newLatestDate)
                        dismiss()
                    }
                }
                .padding()
                .buttonStyle(.borderedProminent)
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            newStreak = "\(userVM.user?.streakCount ?? 0)"
            newLatestDate = userVM.user?.lastMomentDate ?? Date()
        }
        .background(Color.background)
    }
}

#Preview {
    SetStreakView()
}
