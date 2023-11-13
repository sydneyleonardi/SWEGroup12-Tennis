//
//  CreateProfileViewModel.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/27/23.
//

// Error Handling in Create Profile 

import Foundation
import UIKit
import FirebaseStorage

// Creates a User's Profile in Database

@MainActor
final class CreateProfileViewModel: ObservableObject{
    @Published var name = ""
    @Published var gender = ""
    @Published var description = ""
    @Published var age = ""
    @Published var skillLevel = ""
    @Published var playType = ""
    @Published var profileImage:UIImage? = nil
    @Published var profileImageURL = ""
    @Published var datesSelected = Array(repeating:0, count: 15)
    
    func persistImageToStorage() async throws -> String
    {
        let authUser = try AuthManager.shared.fetchUser()
        let ref = Storage.storage().reference(withPath:authUser.uid)
        guard let imageData = profileImage?.jpegData(compressionQuality: 0.5) else 
        {
            throw ImageError.imageDataError
        }
        
        do{
            let _ = try await ref.putData(imageData, metadata: nil)
            let url = try await ref.downloadURL()
            return url.absoluteString
        }catch{
            throw ImageError.storageDownloadError
        }
    }

    // create a profile in database based on user input
    func createUserProfile () async throws
    {
        guard !name.isEmpty, !gender.isEmpty else {
            print ("No name or gender")
            return
        }
        let authUser = try AuthManager.shared.fetchUser()
        
        let profileImageURL = try await persistImageToStorage()
        let user = DBUser(userId: authUser.uid, name: name, gender: gender, age: age, skillLevel: skillLevel, playType: playType, email: authUser.email, description: description, datesSelected: datesSelected, profileImageURL: profileImageURL)
        try await UserManager.shared.createUserProfile(user: user)
    }

    
    // EDIT THESE + HANDLE THEM 
    
    enum ImageError: Error {
        case imageDataError
        case storageUploadError
        case storageDownloadError
    }
}
