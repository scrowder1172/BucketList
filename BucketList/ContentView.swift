//
//  ContentView.swift
//  BucketList
//
//  Created by SCOTT CROWDER on 1/8/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var currentLat: Double = 0.0
    @State private var currentLong: Double = 0.0
    
    @State private var tapLat: Double = 56.0
    @State private var tapLong: Double = -3.0
    
    @State private var locations: [Location] = [Location]()
    
    let startPosition: MapCameraPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .centerLastTextBaseline) {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        // display saved locations
                        ForEach(locations) { location in
                            Annotation(location.name,
                                       coordinate: location.coordinate
                            ) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                            }
                        }
                    }
                    .mapStyle(.hybrid)
                    .onMapCameraChange(frequency: .continuous) { context in
                        currentLat = context.region.center.latitude
                        currentLong = context.region.center.longitude
                    }
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            tapLat = coordinate.latitude
                            tapLong = coordinate.longitude
                            // save locations
                            let newLocation: Location = Location(id: UUID(), name: "TBD", description: "", latitude: tapLat, longitude: tapLong)
                            locations.append(newLocation)
                        }
                    }
                }
                
                Text("Lat: \(currentLat.formatted()), Long: \(currentLong.formatted())")
                    .padding(10)
                    .font(.caption)
                    .background(.green)
                    .foregroundStyle(.black)
                    .clipShape(.capsule)
                    .offset(x: -20, y: -20)
            }
            Text("Lat:\(tapLat.formatted()), Long:\(tapLong.formatted())")
                .padding(10)
                .font(.caption)
                .background(.blue)
                .foregroundStyle(.black)
                .clipShape(.capsule)
                .offset(x: -20, y: 0)
        }
        
        
    }
}

#Preview {
    ContentView()
}
