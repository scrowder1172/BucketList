//
//  EditView.swift
//  BucketList
//
//  Created by SCOTT CROWDER on 1/12/24.
//

import SwiftUI
import MapKit

struct EditView: View {
    
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel: ViewModel
    
    
    var location: Location
    var onSave: (Location) -> Void
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        _viewModel = State(initialValue: ViewModel(name: location.name, description: location.description))
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
                    let newLocation: Location = Location(id: UUID(), name: viewModel.name, description: viewModel.description, latitude: location.latitude, longitude: location.longitude)
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces(location: location)
            }
        }
    }
    
    
}



#Preview {
    EditView(location: .example) { _ in}
}
