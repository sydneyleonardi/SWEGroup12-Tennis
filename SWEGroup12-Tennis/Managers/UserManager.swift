//
//  UserManager.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/16/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

// How user is stored in the database
struct DBUser{
    let userId: String
    let name: String?
    let gender: String?
    let age: String?
    let skillLevel: String?
    let playType: String?
    let email: String?
    let description: String?
    let datesSelected: Array<Int>?
    let profileImageURL:String?
}

// Custom Error if unable to read data from database
enum UserDataError: Error{
    case dataNotFound
}

// Connects to database and manages the current user and all their data

final class UserManager{
    
    static let shared = UserManager()
    private init(){
        
    }
    
    // create a new user in database
    func createNewUser(auth: AuthDataResultModel) async throws {
        let userData: [String:Any] = [
            "id" : auth.uid,
            "email" : auth.email ?? "",
        ]
        //self.persistImageToStorage(uid: auth.uid)
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: true )
        
    }
    
    // create a user profile + store more user information in firebase
    func createUserProfile(user: DBUser) async throws {
        let userData: [String:Any] = [
            "name" : user.name ?? "",
            "gender" : user.gender ?? "",
            "age" : user.age ?? "",
            "skillLevel" : user.skillLevel ?? "",
            "type": user.playType ?? "",
            "description": user.description ?? "",
            "datesSelected": user.datesSelected ?? "",
            "profileImageURL": user.profileImageURL ?? ""
        ]
        try await Firestore.firestore().collection("users").document(user.userId).updateData(userData)
    }
    
    // fetch a user's information from firebase
    func getUser(userId: String) async throws -> DBUser {
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        guard let data = snapshot.data(), let userId = data["id"] as? String else {
            throw UserDataError.dataNotFound
        }
        
        let email = data["email"] as? String
        let name = data["name"] as? String
        let gender = data["gender"] as? String
        let age = data["age"] as? String
        let skillLevel = data["skillLevel"] as? String
        let playType = data["type"] as? String
        let description = data["description"] as? String
        let datesSelected = data["datesSelected"] as? Array<Int>
        let profileImageURL = data["profileImageURL"] as? String
        
        return DBUser(userId: userId, name: name, gender: gender, age: age, skillLevel: skillLevel, playType: playType, email: email, description: description, datesSelected: datesSelected, profileImageURL: profileImageURL)
    }
    
    // delete a user + all their data from the database 
    func deleteUserData(uid:String){
        let reference = Firestore.firestore().collection("users").document(uid)
        reference.delete()
    }
    
    // update a section of user data
    func updateUserData(uid: String, changeCategory: String, change: Any ) async throws {
        try await Firestore.firestore().collection("users").document(uid).updateData([changeCategory: change])
    }
    
}
