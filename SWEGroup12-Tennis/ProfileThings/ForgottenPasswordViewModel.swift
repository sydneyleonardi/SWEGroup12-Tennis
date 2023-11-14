//
//  ForgottenPasswordViewModel.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/27/23.
//
import Foundation

@MainActor
final class ForgottenPasswordViewModel: ObservableObject{
    @Published var email = ""
    @Published var alert = false

    // throw an error if the email line is empty
    func resetPassword() async throws {

        try await AuthManager.shared.resetPassword(email: email)

    }
}
