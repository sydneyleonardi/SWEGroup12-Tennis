//
//  ForgottenPasswordView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/15/23.
//

// TO DO:
// Check that the email even exists

import SwiftUI

struct ForgottenPasswordView: View {
    @StateObject private var viewModel = ForgottenPasswordViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var showSignIn = false
    
    var body: some View {
        VStack(spacing: 10){
            
            Text("Forgot Your Password?")
                .font(.headline)
                .padding(30)
            
            InputView(text: $viewModel.email, title: "Vanderbilt Email")
                .padding(.bottom, 20)
            
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
            .frame(width:300, height:50)
            .background(CustomColor.myColor)
            .cornerRadius(10)
            .foregroundColor(.black)
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0:0.5)
            .alert(isPresented: $viewModel.alert) {
                Alert(title: Text("Reset Sent"),
                      message: Text("An email has been sent to  \(viewModel.email) to reset your password"),
                      dismissButton: .default(Text("OK")) {
                    viewModel.alert = false
                    dismiss()
                })
            }
            
            NavigationLink("", destination: LogInView(), isActive: $showSignIn)
            
            Spacer()
            
        }
    }
}

extension ForgottenPasswordView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !viewModel.email.isEmpty
    }
}

#Preview {
    ForgottenPasswordView()
}
