//
//  ForgottenPasswordView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/15/23.
//

// TO DO:
// Check that the email even exists

import SwiftUI

@MainActor
final class ForgottenPasswordViewModel: ObservableObject{
    @Published var email = ""
    @Published var alert = false
    
    // throw an error if the email line is empty
    func resetPassword() async throws {
        
        try await AuthManager.shared.resetPassword(email: email)
        
    }
}


struct ForgottenPasswordView: View {
    @StateObject private var viewModel = ForgottenPasswordViewModel()
    @Binding var showSignIn: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 10){
            
            Text("Forgot Your Password?")
                .font(.largeTitle)
                .padding(30)
            
            InputView(text: $viewModel.email, title: "Vanderbilt Email")
            
            Button{
                Task{
                    do{
                        try await viewModel.resetPassword()
                        viewModel.alert = true
                        print("Password Reset!")
                    }catch{
                        print(error)
                    }
                }
            }label:{
                Text("Reset Password")
            }
            .padding(30)
            .alert(isPresented: $viewModel.alert) {
                Alert(title: Text("Reset Sent"),
                      message: Text("An email has been sent to  \(viewModel.email) to reset your password"),
                      dismissButton: .default(Text("OK")) {
                    viewModel.alert = false
                    dismiss()
                })
            }
            
            Spacer()
            
        }
    }
}

#Preview {
    ForgottenPasswordView(showSignIn: .constant(false))
}
