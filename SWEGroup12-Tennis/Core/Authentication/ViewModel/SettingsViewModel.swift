//
//  SettingsViewModel.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/26/23.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    // need both access to authentication + user database
    @Published private(set) var user: AuthDataResultModel? = nil
    @Published private(set) var dataUser: DBUser? = nil
    
    // loads the current user from auth manager + user manager
    func loadCurrentUser() async throws {
        let authDataResult = try AuthManager.shared.fetchUser()
        self.user = authDataResult
        self.dataUser = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    // sign out user
    func signOut() throws {
        try AuthManager.shared.signOut()
    }
    
    
    // delete user from auth + user database 
    func deleteAccount() throws {
        try AuthManager.shared.deleteAccount()
        UserManager.shared.deleteUserData(uid: dataUser?.userId ?? "")
        
    }
    
}
