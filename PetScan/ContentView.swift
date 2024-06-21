//
//  ContentView.swift
//  PetScan
//
//  Created by 廖清筆 on 2024/6/10.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserAuthViewModel()

    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        if viewModel.isSignedIn {
            HomeView()
        } else {
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Sign In") {
                    viewModel.signIn(email: email, password: password)
                }
                .padding()
                .buttonStyle(HomeViewButtonStyle())

                Button("Sign Up") {
                    viewModel.signUp(email: email, password: password)
                }
                .padding()
                .buttonStyle(HomeViewButtonStyle())
            }
        }
    }
}


#Preview {
    ContentView()
}
