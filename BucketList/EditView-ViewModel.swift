//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by SCOTT CROWDER on 1/17/24.
//

import SwiftUI

extension EditView {
    @Observable
    final class ViewModel {
        
        enum LoadingState {
            case loading, loaded, failed
        }
        
        var location: Location
        var name: String
        var description: String
        private(set) var pages: [Page] = [Page]()
        private(set) var loadingState: LoadingState = .loading
        
        init(location: Location) {
            self.name = location.name
            self.description = location.description
            self.location = location
        }
        
        func createNewLocation() -> Location {
            let newLocation: Location = Location(id: UUID(), 
                                                 name: name,
                                                 description: description,
                                                 latitude: location.latitude,
                                                 longitude: location.longitude)
            return newLocation
        }
        
        func fetchNearbyPlaces(location: Location) async {
            let urlString: String = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            print(urlString)
            
            guard let url: URL = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let items = try JSONDecoder().decode(Result.self, from: data)
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                print(error.localizedDescription)
                loadingState = .failed
            }
        }
    }
}
