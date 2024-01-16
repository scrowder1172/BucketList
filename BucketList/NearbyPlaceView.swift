//
//  NearbyPlaceView.swift
//  BucketList
//
//  Created by SCOTT CROWDER on 1/16/24.
//

import SwiftUI
import MapKit

struct NearbyPlaceView: View {
    
    let page: Page
    
    var body: some View {
        Map(initialPosition:
                MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: page.lat, longitude: page.long),
                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                    )
                )
        ) {
            Marker(page.title, coordinate: CLLocationCoordinate2D(latitude: page.lat, longitude: page.long))
        }
        .mapStyle(.hybrid)
        .navigationTitle(page.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
