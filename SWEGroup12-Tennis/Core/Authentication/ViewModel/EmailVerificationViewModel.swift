//
//  EmailVerificationViewModel.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 11/12/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth


@MainActor
final class EmailVerificationViewModel: ObservableObject{
    
    // signs in user with inputted email and password
    func resendVerification() async throws {
        
        let user = Auth.auth().currentUser
        try await user?.sendEmailVerification()
    }
    
    // check that the email is verified 
    func checkVerification() async throws {
            
        let user = Auth.auth().currentUser
        try await user?.reload()
       
        if (user?.isEmailVerified != true)
        {
            throw VerificationError.notVerified
        }
    }

    enum VerificationError: Error{
        case notVerified
    }
}
