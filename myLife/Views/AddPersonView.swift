//
//  AddPersonView.swift
//  myLife
//
//  Created by tucker bichsel on 1/10/25.
//

import SwiftUI

struct AddPersonView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var newPersonName = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $newPersonName)
                }
            }
            .navigationTitle("New Person")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        savePerson()
                        newPersonName = ""
                        dismiss()
                    }
                    .disabled(newPersonName.isEmpty) // Disable save if text is empty
                }
            }
        }
    }
    
    private func savePerson() {
        let newPerson = Person(name: newPersonName)
        modelContext.insert(newPerson)
        try? modelContext.save()
    }
}

#Preview {
    AddPersonView()
}
