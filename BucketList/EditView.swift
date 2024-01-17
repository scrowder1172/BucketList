//
//  EditView.swift
//  BucketList
//
//  Created by SCOTT CROWDER on 1/12/24.
//

import SwiftUI
import MapKit

struct EditView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel: ViewModel
    
    var onSave: (Location) -> Void
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        _viewModel = State(initialValue: ViewModel(location: location))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section("Nearby..") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading..")
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            
                            NavigationLink(destination: NearbyPlaceView(page: page)) {
                                Text(page.title)
                                    .font(.headline) +
                                Text(": ") +
                                Text(page.description)
                                    .italic()
                            }
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place Details")
            .toolbar {
                Button("Save") {
                    let newLocation: Location = viewModel.createNewLocation()
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces(location: viewModel.location)
            }
        }
    }
    
    
}



#Preview {
    EditView(location: .example) { _ in}
}
