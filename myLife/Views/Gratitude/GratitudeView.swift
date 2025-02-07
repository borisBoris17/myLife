//
//  GratitudeView.swift
//  myLife
//
//  Created by tucker bichsel on 1/24/25.
//

import SwiftUI
import SwiftData
import WrappingHStack

struct GratitudeView: View {
    var geometry: GeometryProxy
    
    @State private var showAddSheet = false
    @State private var showAddPerson = false
    @State private var selectedPerson: Person = Person.example
    @State private var selectedPeople: Set<Person> = []
    @State private var showManagePeople = false
    
    @Query var people: [Person]
    @Query var momentsOfGratitude: [Gratitude]
    
    private var moments: [Gratitude] {
        guard !selectedPeople.isEmpty else { return [] }
        return momentsOfGratitude.filter { moment in
            moment.people.contains { selectedPeople.contains($0) }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("People")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.brand)
                        
                        Spacer()
                        
                        Button("Manage") {
                            showManagePeople.toggle()
                        }
                    }
                    
                    WrappingHStack(alignment: .leading) {
                        ForEach (people) { person in
                            Button {
                                if selectedPeople.contains(person) {
                                    selectedPeople.remove(person)
                                } else {
                                    selectedPeople.insert(person)
                                }
                            } label: {
                                Text(person.name)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(selectedPeople.contains(person) ? Color.brand : Color.secondary)
                                    .foregroundColor(selectedPeople.contains(person) ? .white : .brand)
                                    .cornerRadius(8)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                        
                        Button {
                            showAddPerson.toggle()
                        } label: {
                            Image(systemName: "person.fill.badge.plus")
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(.brand.opacity(0.65))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .cornerRadius(8)
                        }
                    }
                    
                }
                
                ScrollView {
                    HStack {
                        Text("Moments of Gratitude")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.brand)
                        
                        Spacer()
                    }
                    
                    ForEach(moments) { gratitude in
                        MomentOfGratitudeCardView(gratitude: gratitude)
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    HStack {
                        Spacer()
                        
                        AddMemoryButtonView()
                            .onTapGesture {
                                showAddSheet = true
                            }
                            .padding()
                    }
                    
                }
                
                Spacer()
            }
            .padding()
            .background(Color.background)
        }
        .sheet(isPresented: $showAddPerson) {
            AddPersonView()
        }
        .sheet(isPresented: $showAddSheet) {
            AddGratitudeView()
        }
        .sheet(isPresented: $showManagePeople) {
            ManagePeopleView()
        }
        .onAppear() {
            if selectedPeople.isEmpty {
                for person in people {
                    selectedPeople.insert(person)
                }
            }
        }
    }
}

#Preview {
    GeometryReader() { geometry in
        GratitudeView(geometry: geometry)
    }
}
