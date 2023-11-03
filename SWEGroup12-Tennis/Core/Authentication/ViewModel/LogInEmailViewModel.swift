//
//  LogInEmailViewModel.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/26/23.
//

import Foundation

// LogInEmailViewModel
// used in conjunction with LogInView

@MainActor
final class LogInEmailViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    
    
    // signs in user with inputted email and password
    func signIn() async throws {
        
        try await AuthManager.shared.signInUser(email: email, password: password)
        }
}
