//
//  MapKitExample.swift
//  BucketList
//
//  Created by SCOTT CROWDER on 1/10/24.
//

import SwiftUI
import MapKit

struct MapKitExample: View {
    var body: some View {
        TabView {
            MapKitBasicExampleView()
                .tabItem {
                    Label("Basic", systemImage: "map.circle")
                }
            TrafficMapExampleView()
                .tabItem {
                    Label("Traffic", systemImage: "car.circle")
                }
            MapStyleExampleView()
                .tabItem {
                    Label("MapStyles", systemImage: "map.circle")
                }
            MapPositionExampleView()
                .tabItem {
                    Label("Position", systemImage: "mappin.circle")
                }
        }
    }
}

struct MapKitBasicExampleView: View {
    var body: some View {
        Map()
    }
}

struct TrafficMapExampleView: View {
    var body: some View {
        VStack {
            Map()
                .mapStyle(.hybrid(elevation: .realistic, showsTraffic: true))
        }
    }
}

struct MapStyleExampleView: View {
    
    var body: some View {
        VStack {
            Map()
                .mapStyle(.hybrid(elevation: .realistic, pointsOfInterest: .all, showsTraffic: true))
        }
        
        
    }
}

struct MapPositionExampleView: View {
    @State private var position: MapCameraPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.50722, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
        
    )
    
    var body: some View {
        VStack {
            Map(position: $position)
                .mapStyle(.hybrid)
                .padding(.bottom)
            HStack {
                Button("London") {
                    position = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: 51.50722, longitude: -0.1275),
                            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                        )
                    )
                }
                .padding(.horizontal)
                Button("Paris") {
                    position = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
                            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                        )
                    )
                }
                Button("Tokyo") {
                    position = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922),
                            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                        )
                    )
                }
                .padding(.horizontal)
            }
            .padding()
            
        }
    }
}

#Preview {
    MapKitExample()
}
