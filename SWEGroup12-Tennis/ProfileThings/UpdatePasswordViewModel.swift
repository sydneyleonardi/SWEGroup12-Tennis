//
//  UpdatePasswordViewModel.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/27/23.
//
import Foundation

@MainActor
final class UpdatePasswordViewModel: ObservableObject{
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var alert = false

    func updatePassword() async throws {
        try await AuthManager.shared.updatePassword(newPassword: password)
    }
}
