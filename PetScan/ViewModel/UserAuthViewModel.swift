//
//  UserAuthViewModel.swift
//  PetScan
//
//  Created by 廖清筆 on 2024/6/21.
//

import SwiftUI
import FirebaseAuth

class UserAuthViewModel: ObservableObject {
    @Published var isSignedIn: Bool = false

    private var authStateListener: AuthStateDidChangeListenerHandle?

    init() {
        authStateListener = Auth.auth().addStateDidChangeListener { _, user in
            self.isSignedIn = user != nil
        }
    }

    deinit {
        if let listener = authStateListener {
            Auth.auth().removeStateDidChangeListener(listener)
        }
    }

    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to sign in: \(error.localizedDescription)")
            } else {
                print("Signed in user: \(result?.user.email ?? "")")
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("Failed to sign out: \(error.localizedDescription)")
        }
    }

    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to sign up: \(error.localizedDescription)")
            } else {
                print("Created user: \(result?.user.email ?? "")")
            }
        }
    }
}

