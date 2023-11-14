//
//  SignUpView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/15/23.
//


import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    
    @StateObject private var viewModel = SignUpEmailViewModel()
    @State private var createUser = false
    
    // error variables
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
                
                // Email Input
                InputView(text: $viewModel.email, title: "Vanderbilt Email")
                
                // Password Input
                InputView(text: $viewModel.password, title: "Password", isSecureField: true)
                
                // Confirm Password Input
                ZStack(alignment: .trailing){
                    InputView(text: $viewModel.confirmPassword, title: "Confirm Password", isSecureField: true)
                    
                    // Icon to show user if passwords match
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
                        createUser = true
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
            
            // Navigates to Create Profile Page
            NavigationLink("", destination: CreateProfileView().navigationBarBackButtonHidden(true), isActive: $createUser)
            
            
            // Navigates to Log In Page
            NavigationLink{
                LogInView()
                    .navigationBarBackButtonHidden(true)
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

// Validation for Sign Up
extension SignUpView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !viewModel.email.isEmpty
        && viewModel.email.contains("@vanderbilt.edu")
        && !viewModel.password.isEmpty
        && viewModel.password.count > 8
        && viewModel.password == viewModel.confirmPassword
    }
}


#Preview {
    SignUpView()
}
