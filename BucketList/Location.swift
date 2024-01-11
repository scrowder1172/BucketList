//
//  Location.swift
//  BucketList
//
//  Created by SCOTT CROWDER on 1/11/24.
//

import Foundation

struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
}
