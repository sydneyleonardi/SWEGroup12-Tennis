//
//  SignUpEmailViewModel.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/26/23.
//

import Foundation

// SignUpEmailViewModel
// used in conjunction with SignUpView

@MainActor
final class SignUpEmailViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    
    // signs up user with user inputted email + password and makes a new user in the database
    func signUp()async throws {
        
        let AuthDataResult = try await AuthManager.shared.createUser(email: email, password: password)
        try await UserManager.shared.createNewUser(auth: AuthDataResult)
    }
    
}
