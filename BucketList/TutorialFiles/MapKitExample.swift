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
            AnnotationsViewExample()
                .tabItem {
                    Label("Annotations", systemImage: "mappin.and.ellipse.circle")
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
    
    @State private var lat = 0.0
    @State private var long = 0.0
    @State private var spanLat = 0.0
    @State private var spanLong = 0.0
    
    var body: some View {
        VStack {
            HStack {
                Text("Latitude: \(lat)")
                Text("Longitude: \(long)")
                Text("Span Lat: \(spanLat)")
                Text("Span Long: \(spanLong)")
            }
            .padding(.vertical)
            Map(position: $position)
                .mapStyle(.hybrid)
                .onMapCameraChange { context in
                    lat = context.region.center.latitude
                    long = context.region.center.longitude
                    spanLat = context.region.span.latitudeDelta
                    spanLong = context.region.span.longitudeDelta
                    let location: String = """
Location:
    Latitude: \(lat)
    Longitude: \(long)
Span:
    Lat: \(spanLat)
    Long: \(spanLong)
"""
                    print(location)
                }
                .frame(height: 400)
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
            }
            .padding()
            
        }
    }
}

struct AnnotationsViewExample: View {
    
    struct Location: Identifiable {
        let id: UUID = UUID()
        var name: String
        var coordinate: CLLocationCoordinate2D
    }
    
    let locations: [Location] = [
        Location(name: "Buckingham Palace",
                 coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London",
                 coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076)),
        Location(name: "Golden Gate Bridge",
                 coordinate: CLLocationCoordinate2D(latitude: 37.819542, longitude: -122.478530)),
    ]
    
    var body: some View {
        Map {
            ForEach(locations) { location in
                Annotation(location.name, coordinate: location.coordinate) {
                    Text(location.name)
                        .font(.headline)
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                }
                .annotationTitles(.hidden)
            }
        }
    }
}

struct MapReaderViewExample: View {
    var body: some View {
        MapReader { proxy in
            Map()
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        print(coordinate)
                    }
                }
        }
    }
}

#Preview {
    MapReaderViewExample()
}
