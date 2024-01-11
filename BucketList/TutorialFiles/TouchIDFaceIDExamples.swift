//
//  TouchIDFaceIDExamples.swift
//  BucketList
//
//  Created by SCOTT CROWDER on 1/11/24.
//

import SwiftUI
import LocalAuthentication

struct TouchIDFaceIDExamples: View {
    
    @State private var isUnlocked: Bool = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Your data has been unlocked.")
            } else {
                Text("Your data is protected.")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context: LAContext = LAContext()
        var error: NSError?
        
        // check if biometrics is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason: String = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication is now complete
                if success {
                    // authenticated successfully
                    isUnlocked = true
                } else {
                    // there was a problem
                    /// Additional code is required to rerun the biometrics authentication
                    /// Also a decision is needed regarding how many times to attempt biometrics before failing to a secondary authentication method
                }
            }
        } else {
            // no biometrics
            /// Code is required to handle authenticating users who do not have or want biometrics authentication
        }
    }
}

#Preview {
    TouchIDFaceIDExamples()
}
