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
    @State private var verifyEmail = false
    
    // error variables
    @State private var errorAlert = false
    @State private var errorMessage = ""
    
    @State private var showPopUpEmail = false
    @State private var showPopUpPassword = false
    
    var body: some View {
        VStack(){
            
            // App Icon
            Image("Logo")
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .padding(.vertical, 10)
            
            // App Name
            Text("Vandy Tennis")
                .font(.largeTitle)
            
            // Form Fields
            VStack(spacing:15){
                
                // Email Input
                ZStack(alignment: .trailing){
                    InputView(text: $viewModel.email, title: "Vanderbilt Email")
                    
                    Button
                    {
                       showPopUpEmail = true
                    }label:{
                        Image(systemName: "info.circle")
                            .imageScale(.large)
                            .fontWeight(.bold)
                            .foregroundColor(Color(.systemGray))
                            .padding(.trailing, 5)
                    }
                    .popover(isPresented:$showPopUpEmail){
                        VStack{
                            Text("Email must be a valid Vanderbilt Univeristy email address")
                        }
                        .presentationCompactAdaptation(.popover)
                    }
                
                }
                
                // Password Input
                ZStack(alignment: .trailing){
                    InputView(text: $viewModel.password, title: "Password", isSecureField: true)
                    
                    Button
                    {
                       showPopUpPassword = true
                    }label:{
                        Image(systemName: "info.circle")
                            .imageScale(.large)
                            .fontWeight(.bold)
                            .foregroundColor(Color(.systemGray))
                            .padding(.trailing, 5)
                    }
                    .popover(isPresented:$showPopUpPassword){
                        VStack{
                            Text("Password must be greater than 8 characters")
                        }
                        .presentationCompactAdaptation(.popover)
                    }
                
                }
                
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
                        verifyEmail = true
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
            NavigationLink("", destination: EmailVerificationView().navigationBarBackButtonHidden(true), isActive: $verifyEmail)
            
            
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
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
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
