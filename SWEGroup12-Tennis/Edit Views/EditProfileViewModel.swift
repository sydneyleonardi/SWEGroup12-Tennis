//
//  EditProfileViewModel.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/31/23.
//
import Foundation

@MainActor
final class EditProfileViewModel: ObservableObject{

    // change variables
    @Published var changeCategory = ""
    @Published var change =  ""

    // allows us to change availability array
    @Published var dates = false
    @Published var changeArray = Array(repeating:0, count: 15)

    @Published private(set) var user: DBUser? = nil
    @Published private(set) var authUser: AuthDataResultModel? = nil


    // allows you to edit portion of the user profile
    func editUserProfile () async throws
    {
        // fetch the auth and database user
        let authDataResult = try AuthManager.shared.fetchUser()
        self.authUser = authDataResult
        self.user = try await UserManager.shared.getUser(userId: authUser?.uid ?? "")

        if(!dates)
        {
            try await UserManager.shared.updateUserData(uid: authUser?.uid ?? "", changeCategory: changeCategory, change: change)
        } else {
            try await UserManager.shared.updateUserData(uid: authUser?.uid ?? "", changeCategory: changeCategory, change: changeArray)
        }
    }
}
