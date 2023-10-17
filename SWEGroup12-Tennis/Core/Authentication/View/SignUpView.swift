//
//  SignUpView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/15/23.
//

// TO DO
// Add in error + authentication protocol + alerts 

import SwiftUI
import FirebaseAuth

@MainActor
final class SignUpEmailViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    func signUp()async throws {
        
        let AuthDataResult = try await AuthManager.shared.createUser(email: email, password: password)
        try await UserManager.shared.createNewUser(auth: AuthDataResult)
    }
    
}

struct SignUpView: View {
    
    @StateObject private var viewModel = SignUpEmailViewModel()
    @Binding var showSignIn: Bool
    @Binding var showCreateUser: Bool
    @Environment(\.dismiss) var dismiss
    @State private var errorAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(){
            
            // App Icon
            Image("Logo")
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .padding(.vertical, 10)
            
            // App Name
            Text("Get Matched.")
                .font(.largeTitle)
            
            // Form Fields
            VStack(spacing:15){
                InputView(text: $viewModel.email, title: "Vanderbilt Email")
                
                
                InputView(text: $viewModel.password, title: "Password", isSecureField: true)
                
                ZStack(alignment: .trailing){
                    InputView(text: $viewModel.confirmPassword, title: "Confirm Password", isSecureField: true)
                    if !viewModel.password.isEmpty && !viewModel.confirmPassword.isEmpty
                    {
                        if viewModel.password == viewModel.confirmPassword{
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                                .padding(.trailing, 5)
                        } else{
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                                .padding(.trailing, 5)
                        }
                    }
                }
            }
            
            // Sign Up Button
            Button {
                Task{
                    do{
                        try await viewModel.signUp()
                        showSignIn = false
                        showCreateUser = true
                        return
                    }catch AuthErrorCode.emailAlreadyInUse{
                        errorAlert = true
                        errorMessage = " \(viewModel.email) is already in use!"
                    }catch AuthErrorCode.networkError{
                        errorAlert = true
                        errorMessage = "There was a problem with your network. Please check your internet connection and try again."
                    }catch{
                        errorAlert = true
                        errorMessage = "Sorry, your request cannot be fulfilled right now. Please try again later."
                    }
                }
            }label:{
                Text("Sign Up")
                    .foregroundColor(.black)
                    .bold()
                    .frame(width:300, height:50)
            }
            .background(CustomColor.myColor)
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0:0.5)
            .cornerRadius(10)
            .padding(.top, 5)
            // Pop up Alert 
            .alert(isPresented: $errorAlert) {
                Alert(title: Text("Oops"),
                      message: Text(errorMessage),
                      dismissButton: .default(Text("OK")) {
                    errorAlert = false
                    viewModel.email = ""
                    viewModel.password = ""
                    viewModel.confirmPassword = ""
                })
            }
            
            
            // Sign In Page
            Button{
                dismiss()
            }label:{
                HStack(spacing: 5){
                    Text("Already have an account?")
                    Text("Sign in!")
                        .bold()
                }
                .font(.system(size:14))
                .padding()
            }
            
        }
        
        
    }
        
}

// Validation
extension SignUpView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !viewModel.email.isEmpty
        && viewModel.email.contains("@")
        && !viewModel.password.isEmpty
        && viewModel.password.count > 8
        && viewModel.password == viewModel.confirmPassword
    }
}


#Preview {
    SignUpView(showSignIn: .constant(false), showCreateUser: .constant(false))
}
