//
//  AuthManager.swift
//
//  Created by Sydney Leonardi on 10/15/23.
//

import Foundation
import FirebaseAuth

// User Credentials
struct AuthDataResultModel {
    let uid: String
    let email: String?
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
    }
}

// Custom Error when unable to fetch user from authentication
enum UserFetchError: Error{
    case noAuthenticatedUser
}

protocol AuthenticationFormProtocol{
    var formIsValid: Bool {get}
}

// Connects to the database and managers all authentication procedures in the app
final class AuthManager {
    
    static let shared = AuthManager()
    private init(){}
    
    
    // create a user within the Firebase database
    @discardableResult
    func createUser(email: String, password: String)async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    // read / grab a user from the database
    func fetchUser() throws ->AuthDataResultModel{
        guard let user = Auth.auth().currentUser else {
            throw UserFetchError.noAuthenticatedUser
        }
        
        return AuthDataResultModel(user: user)
    }
    
    // sign a user out
    func signOut() throws{
        try Auth.auth().signOut()
    }
    
    // sign a user in
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    // delete a user's account from Authentication database 
    func deleteAccount() throws {
        guard let user = Auth.auth().currentUser else{
            throw UserFetchError.noAuthenticatedUser
        }
        user.delete()
    }
    
    // update a user's password
    func updatePassword(newPassword: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw UserFetchError.noAuthenticatedUser
        }
        
        try await user.updatePassword(to: newPassword)
        
    }
    
    // reset a user's password if they cannot remember it 
    func resetPassword(email: String) async throws {
       try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}
