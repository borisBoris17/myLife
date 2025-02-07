//
//  ManagePeopleView.swift
//  myLife
//
//  Created by tucker bichsel on 2/6/25.
//

import SwiftUI
import SwiftData

struct ManagePeopleView: View {
    @State private var showAddPerson = false
    
    @Query var people: [Person]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(people) { person in
                    ManagePersonView(person: person)
                }
                
                HStack {
                    Button {
                        showAddPerson.toggle()
                    } label: {
                        Image(systemName: "person.fill.badge.plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25) // Ensures a uniform icon size
                            .padding(8) // Consistent padding
                            .background(.brand.opacity(0.65))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .cornerRadius(8)
                    }
                    
                    Spacer()
                }
            }
            .padding(.horizontal)
            .sheet(isPresented: $showAddPerson) {
                AddPersonView()
            }
            .navigationTitle("Manage People")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ManagePersonView: View {
    var person: Person
    
    @State var name: String = ""
    @State var editMode = false
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        HStack {
            Button {
                
                if editMode {
                    do {
                        person.name = name
                        try modelContext.save()
                    } catch {
                        print("Error saving context: \(error) while editing name \(person.name)")
                    }
                }
                
                editMode.toggle()
            } label: {
                Image(systemName: editMode ? "checkmark.square" : "pencil")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25) // Ensures a uniform icon size
                    .padding(8) // Consistent padding
                    .background(.brand.opacity(0.65))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .cornerRadius(8)
            }
            
            Button {
                print("delete name")
                modelContext.delete(person)
            } label: {
                Image(systemName: "trash")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25) // Same icon size as the edit button
                    .padding(8)
                    .background(.brand.opacity(0.65))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .cornerRadius(8)
            }
            
            TextField("Name", text: $name)
                .font(.title2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .disabled(!editMode)
        }
        .onAppear() {
            name = person.name
        }
    }
}

#Preview {
    ManagePeopleView()
}
