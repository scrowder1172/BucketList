//
//  ContentView.swift
//  BucketList
//
//  Created by SCOTT CROWDER on 1/8/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var viewModel: ViewModel = ViewModel()
    
    let startPosition: MapCameraPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    @AppStorage("mapStyle") private var mapStyle: String = "standard"
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack(alignment: .topLeading) {
                ZStack(alignment: .topTrailing) {
                    ZStack(alignment: .centerLastTextBaseline) {
                        MapReader { proxy in
                            Map(initialPosition: startPosition) {
                                // display saved locations
                                ForEach(viewModel.locations) { location in
                                    Annotation(location.name,
                                               coordinate: location.coordinate
                                    ) {
                                        Image(systemName: "star.circle")
                                            .resizable()
                                            .foregroundStyle(.red)
                                            .frame(width: 44, height: 44)
                                            .background(.white)
                                            .clipShape(.circle)
                                            .onLongPressGesture {
                                                viewModel.selectedPlace = location
                                            }
                                    }
                                }
                            }
                            .mapStyle(mapStyle == "standard" ? .standard : .hybrid)
                            .onMapCameraChange(frequency: .continuous) { context in
                                viewModel.setCurrentLocation(coordinates: context.region.center)
                            }
                            .onTapGesture { position in
                                if let coordinate = proxy.convert(position, from: .local) {
                                    viewModel.addLocation(at: coordinate)
                                }
                            }
                            .sheet(item: $viewModel.selectedPlace) { place in
                                //Text(place.name)
                                EditView(location: place) {
                                    viewModel.updateLocation(location: $0)
                                }
                            }
                        }
                        
                        Text("Lat: \(viewModel.currentLat.formatted()), Long: \(viewModel.currentLong.formatted())")
                            .padding(10)
                            .font(.caption)
                            .background(.green)
                            .foregroundStyle(.black)
                            .clipShape(.capsule)
                            .offset(x: -20, y: -20)
                    }
                    Text("Lat:\(viewModel.tapLat.formatted()), Long:\(viewModel.tapLong.formatted())")
                        .padding(10)
                        .font(.caption)
                        .background(.blue)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                        .offset(x: -20, y: 0)
                }
                Button {
                    if mapStyle == "standard" {
                        mapStyle = "hybrid"
                    } else {
                        mapStyle = "standard"
                    }
                } label: {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .background(.black)
                }
                .offset(x: 20, y: 20)
            }
            
        } else {
            Button("Unlock data") {
                viewModel.authenticate()
            }
            .buttonStyle(BorderedButtonStyle())
            .alert("Auth Error", isPresented: $viewModel.isAuthenticationFailed) {
                Button("OK") {}
            } message: {
                Text(viewModel.authFailedMessage)
            }
        }
        
        
    }
}

#Preview {
    ContentView()
}
