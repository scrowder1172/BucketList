//
//  ComparableExample.swift
//  BucketList
//
//  Created by SCOTT CROWDER on 1/8/24.
//

import SwiftUI

struct ComparableExample: View {
    var body: some View {
        TabView {
            NumericComparison()
                .tabItem {
                    Label("Numeric", systemImage: "list.number")
                }
            NameComparison()
                .tabItem {
                    Label("Name", systemImage: "pencil.and.list.clipboard")
                }
        }
    }
}

struct NumericComparison: View {
    let values = [1, 5, 3, 6, 2, 9].sorted()
    
    var body: some View {
        List(values, id: \.self) {
            Text(String($0))
        }
    }
}

struct User: Identifiable, Comparable {
    let id: UUID = UUID()
    var firstName: String
    var lastName: String
    
    static func <(lhs: User, rhs: User) -> Bool {
        if lhs.lastName < rhs.lastName {
            return true
        } else if lhs.lastName == rhs.lastName && lhs.firstName < rhs.firstName {
            return true
        }
        
        return false
    }
}

struct NameComparison: View {
    
    let users:[User] = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "Simon", lastName: "Lister"),
        User(firstName: "David", lastName: "Lister")
    ].sorted()
    
    var body: some View {
        List(users) { user in
            Text("\(user.lastName), \(user.firstName)")
        }
    }
}

#Preview {
    ComparableExample()
}
