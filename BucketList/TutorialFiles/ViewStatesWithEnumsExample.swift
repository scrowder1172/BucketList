//
//  ViewStatesWithEnumsExample.swift
//  BucketList
//
//  Created by SCOTT CROWDER on 1/10/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct ViewStatesWithEnumsExample: View {
    
    enum LoadingState: String, CaseIterable, Identifiable {
        case loading, success, failed
        
        var id: Self { self }
    }
    
    @State private var loadingState: LoadingState = .loading
    
    var body: some View {
        Picker("Select State", selection: $loadingState) {
            ForEach(LoadingState.allCases) { state in
                Text(state.rawValue.capitalized)
                    .tag(state)
            }
        }
        .pickerStyle(WheelPickerStyle())
        
        VStack {
            switch loadingState {
            case .loading:
                LoadingView()
            case .success:
                SuccessView()
            case .failed:
                FailedView()
            }
        }
    }
}

#Preview {
    ViewStatesWithEnumsExample()
}
