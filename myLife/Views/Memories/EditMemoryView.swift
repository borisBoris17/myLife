//
//  EditMemoryView.swift
//  myLife
//
//  Created by tucker bichsel on 2/6/25.
//

import SwiftUI
import SwiftData
import WrappingHStack
import _PhotosUI_SwiftUI

struct EditMemoryView: View {
    var memory: Memory
    
    @Environment(\.dismiss) var dismiss // For dismissing the form if presented as a sheet
    @Environment(\.modelContext) var modelContext // Access the SwiftData model context
    
    // State properties to hold form input
    @State private var memoryDate: Date = Date() // Default to the current date
    @State private var memoryTitle: String = ""
    @State private var memoryText: String = ""
    @State private var memoryMood: MoodOption? = nil
    @State private var isDatePickerExpanded: Bool = false
    @State private var isSelected = false
    @State private var showAddPerson = false
    @State private var selectedPeople = Set<Person>()
    @State private var photoItem: PhotosPickerItem?
    @State private var imageData: Data?
    @State private var image: Image?
    
    @Query var people: [Person]
    
    func updateImage() {
        if let selectedImageData = imageData,
           let uiImage = UIImage(data: selectedImageData) {
            image = Image(uiImage: uiImage)
        }
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                Form {
                    
                    Section(header: Text("Title")) {
                        TextField("Memory Title", text: $memoryTitle)
                    }
                    
                    Section {
                        DisclosureGroup(
                            isExpanded: $isDatePickerExpanded,
                            content: {
                                DatePicker("Memory Date", selection: $memoryDate, displayedComponents: .date)
                                    .datePickerStyle(GraphicalDatePickerStyle())
                                    .padding(.vertical)
                            },
                            label: {
                                HStack {
                                    Text("Date")
                                        .font(.headline)
                                    Spacer()
                                    Text(memoryDate, style: .date)
                                        .foregroundColor(.secondary)
                                }
                            }
                        )
                    }
                    
                    Section(header: Text("People"), footer:
                                HStack {
                        Spacer()
                        
                        Button("Add Person") {
                            showAddPerson = true
                        }
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
                    
                    Section(header: Text("Mood")) {
                        VStack {
                            HStack {
                                ZStack {
                                    Text(memoryMood?.name ?? "")
                                        .font(.headline)
                                    
                                    if memoryMood == nil {
                                        Text("Spacer Text").font(.headline).opacity(0)
                                    }
                                }
                                
                                Spacer()
                            }
                                
                            
                            HStack {
                                ForEach(MoodOption.allCases.indices, id: \.self) { index in
                                    Button() {
                                        if memoryMood == MoodOption.allCases[index] {
                                            memoryMood = nil
                                        } else {
                                            memoryMood = MoodOption.allCases[index]
                                        }
                                    } label: {
                                        Text(MoodOption.allCases[index].rawValue)
                                            .font(.title)
                                            .padding(8)
                                            .background(memoryMood == MoodOption.allCases[index] ? Color.brand : Color.clear)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                    
                                    if index < MoodOption.allCases.count - 1 {
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("Memory")) {
                        TextEditor(text: $memoryText)
                            .frame(minHeight: 100) // Give the editor enough space
                    }
                    
                    Section(header: Text("Image"), footer:
                                HStack {
                        Spacer()
                        
                        Button("Remove") {
                            imageData = nil
                            photoItem = nil
                            image = nil
                        }
                        .disabled(image == nil)
                    }) {
                        ImagePickerView(photoItem: $photoItem, selectedImageData: $imageData, imageSize: geometry.size.width * 0.15)
                            .onChange(of: imageData) {
                                updateImage()
                            }
                    }
                }
                .sheet(isPresented: $showAddPerson) {
                    AddPersonView()
                }
                .navigationTitle("New Memory")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            saveMemory()
                            memoryTitle = ""
                            memoryText = ""
                            memoryDate = Date()
                            dismiss()
                        }
                        .disabled(memoryText.isEmpty) // Disable save if text is empty
                    }
                }
            }
            .onAppear() {
                memoryDate = memory.date
                memoryTitle = memory.title
                memoryMood = memory.mood
                memoryText = memory.memoryText
                imageData = memory.imageData ?? Data()
                selectedPeople = Set(memory.unwrappedPeople)
                updateImage()
            }
        }
    }
    
    // Save the new memory
    private func saveMemory() {
        memory.date = memoryDate
        memory.title = memoryTitle
        memory.mood = memoryMood
        memory.memoryText = memoryText
        memory.people = Array(selectedPeople)
        memory.imageData = imageData
        try? modelContext.save() // Save changes
        MemoryExporter.updateMemory(memory)
    }
}

#Preview {
    EditMemoryView(memory: .example)
}
