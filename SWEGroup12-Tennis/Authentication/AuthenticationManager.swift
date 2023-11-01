//
//  AuthenticationManager.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 9/28/23.
//
/*
import Foundation
import FirebaseAuth

struct AuthDataResultModel{
    let uid:String
    let email: String?
    let photoUrl: String?
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
        
    }
}

final class AuthenticationManager {
    
    // making a Singleton
    // is not recommended in larger applications, there are some limitations
    static let shared = AuthenticationManager()
    private init() {
    }
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel
    {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password )
        return AuthDataResultModel(user: authDataResult.user)
        
    }
    
}
*/
