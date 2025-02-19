//
//  EditGratitudeView.swift
//  myLife
//
//  Created by tucker bichsel on 2/7/25.
//

import SwiftUI
import WrappingHStack
import SwiftData

struct EditGratitudeView: View {
    var gratitude: Gratitude
    
    @Environment(\.dismiss) var dismiss // For dismissing the form if presented as a sheet
    @Environment(\.modelContext) var modelContext // Access the SwiftData model context
    
    // State properties to hold form input
    @State private var text: String = ""
    @State private var selectedPeople = Set<Person>()
    
    @Query var people: [Person]
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                Form {
                    
                    Section(header: Text("People"), footer:
                                HStack {
                        Spacer()
                        
                    }
                    ) {
                        WrappingHStack(alignment: .leading) {
                            ForEach (people) { person in
                                Button {
                                    print(person.name)
                                    if selectedPeople.contains(person) {
                                        selectedPeople.remove(person)
                                    } else {
                                        selectedPeople.insert(person)
                                    }
                                } label: {
                                    Text(person.name)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background(selectedPeople.contains (person) ? Color.brand : Color.secondary)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    }
                    
                    Section(header: Text("Moment of Gratitude")) {
                        TextEditor(text: $text)
                            .frame(minHeight: 100) // Give the editor enough space
                    }
                }
                .navigationTitle("Edit Moment")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            saveGratitude()
                            text = ""
                            dismiss()
                        }
                        .disabled(text.isEmpty) // Disable save if text is empty
                    }
                }
            }
            .onAppear() {
                text = gratitude.text
                selectedPeople = Set(gratitude.unwrappedPeople)
            }
        }
    }
    
    // Save the new memory
    private func saveGratitude() {
        gratitude.text = text
        gratitude.people = Array(selectedPeople)
        
        try? modelContext.save() // Save changes
    }
}

#Preview {
    EditGratitudeView(gratitude: .example)
}
