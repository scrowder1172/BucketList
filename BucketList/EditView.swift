//
//  EditView.swift
//  BucketList
//
//  Created by SCOTT CROWDER on 1/12/24.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var location: Location
    
    @State private var name: String
    @State private var description: String
    
    var onSave: (Location) -> Void
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Place Details")
            .toolbar {
                Button("Save") {
                    var newLocation: Location = Location(id: UUID(), name: name, description: description, latitude: location.latitude, longitude: location.longitude)
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    EditView(location: .example) { _ in}
}
