//
//  Result.swift
//  BucketList
//
//  Created by SCOTT CROWDER on 1/12/24.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let coordinates: [Cooridinate]?
    let terms: [String: [String]]?
    
    var description: String {
        terms?["description"]?.first ?? "No further information"
    }
    
    var lat: Double {
        coordinates?.first?.lat ?? 0.0
    }
    
    var long: Double {
        coordinates?.first?.lon ?? 0.0
    }
    
    static func <(lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
    
}

struct Cooridinate: Codable, Equatable {
    let lat: Double
    let lon: Double
}
