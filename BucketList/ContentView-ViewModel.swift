//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by SCOTT CROWDER on 1/17/24.
//

import CoreLocation
import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    @Observable
    final class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        
        private(set) var currentLat: Double = 0.0
        private(set) var currentLong: Double = 0.0
        
        private(set) var tapLat: Double = 56.0
        private(set) var tapLong: Double = -3.0
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        var isUnlocked: Bool = false
        
        init() {
            do {
                let data: Data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                print(error.localizedDescription)
                locations = []
            }
        }
        
        func save() {
            do {
                let data: Data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data: \(error.localizedDescription)")
            }
        }
        
        func setCurrentLocation(coordinates: CLLocationCoordinate2D) {
            currentLat = coordinates.latitude
            currentLong = coordinates.longitude
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            tapLat = point.latitude
            tapLong = point.longitude
            let newLocation: Location = Location(id: UUID(), name: "TBD", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        
        func updateLocation(location: Location) {
            guard let selectedPlace else {return}
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            let context: LAContext = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason: String = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationFailed in
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error authenticating
                        if let authenticationFailed {
                            print("Error authenticating user: \(authenticationFailed)")
                        } else {
                            
                            print("Error authenticating user: UNKNOWN")
                        }
                    }
                }
            } else {
                // no biometrics
                print("No biometrics configured")
            }
        }
    }
}
