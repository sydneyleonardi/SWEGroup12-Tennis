//
//  UserManager.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/16/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser{
    let userId: String
    let name: String?
    let gender: String?
    let age: String?
    let skillLevel: String?
    let playType: String?
    let email: String?
    let description: String?
}

final class UserManager{
    
    static let shared = UserManager()
    private init(){
        
    }
    
    func createNewUser(auth: AuthDataResultModel) async throws {
        let userData: [String:Any] = [
            "id" : auth.uid,
            "email" : auth.email ?? "",
        ]
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: true )
        
    }
    
    func createUserProfile(user: DBUser) async throws {
        let userData: [String:Any] = [
            "name" : user.name ?? "",
            "gender" : user.gender ?? "",
            "age" : user.age ?? "",
            "skillLevel" : user.skillLevel ?? "",
            "type": user.playType ?? "",
            "description": user.description ?? ""
        ]
        
        try await Firestore.firestore().collection("users").document(user.userId).updateData(userData)
    }
    
    func getUser(userId: String) async throws -> DBUser {
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        guard let data = snapshot.data(), let userId = data["id"] as? String else {
            throw URLError(.badServerResponse)
        }
        
    
        let email = data["email"] as? String
        let name = data["name"] as? String
        let gender = data["gender"] as? String
        let age = data["age"] as? String
        let skillLevel = data["skillLevel"] as? String
        let playType = data["type"] as? String
        let description = data["description"] as? String
        
        return DBUser(userId: userId, name: name, gender: gender, age: age, skillLevel: skillLevel, playType: playType, email: email, description: description)
    }
    
}
