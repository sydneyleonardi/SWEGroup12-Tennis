//
//  LogInView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/15/23.
//

// TO DO
// Fix error + authentication rules + alerts 

import SwiftUI

struct LogInView: View {
    @StateObject private var viewModel = LogInEmailViewModel()
    
    // error messages
    @State private var errorAlert = false
    @State private var errorMessage = ""
    
    // navigation variable
    @State private var showProfile = false
    
    var body: some View {
        NavigationStack{
            VStack{
                
                // App Icon
                Image("Logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .padding(.vertical, 10)
                
                // Title of App
                Text("Get Matched.")
                    .font(.largeTitle)
                
                // Text Fields for Email + Password
                VStack(spacing:15){
                    InputView(text: $viewModel.email, title: "Email")
                    
                    InputView(text: $viewModel.password, title: "Password", isSecureField: true)
                    
                }
                
                // Forgot your Password
                NavigationLink{
                    ForgottenPasswordView()
                }label:{
                    Text("Forgot your password?")
                }
                .padding(.vertical, 10)
                .font(.system(size:14))
                
                // Sign In Button
                Button {
                    Task{
                        do{
                            try await viewModel.signIn()
                            showProfile = true
                        }catch{
                            errorAlert = true
                        }
                    }
                } label: {
                    Text("Sign in")
                        .foregroundColor(.black)
                        .bold()
                        .frame(width:300, height:50)
                }
                .background(CustomColor.myColor)
                .cornerRadius(10)
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0: 0.5)
                .alert(isPresented: $errorAlert) {
                    Alert(title: Text("Invalid Login"),
                          message: Text("Email and/or password are invalid"),
                          dismissButton: .default(Text("OK")) {
                        errorAlert = false
                        viewModel.email = ""
                        viewModel.password = ""
                    })
                }
                
                // Navigates to Profile View after Log In
                NavigationLink("", destination: HomeView().navigationBarBackButtonHidden(true), isActive: $showProfile)

                
                // Navigates to Sign Up 
                NavigationLink{
                    SignUpView()
                        .navigationBarBackButtonHidden(true)
                }label:{
                    HStack(spacing: 5){
                        Text("Don't have an account?")
                        Text("Sign up!")
                            .bold()
                    }
                    .font(.system(size:14))
                    .padding()
                }
            }
            
        }
    }
}


// Validation for Log In
extension LogInView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !viewModel.email.isEmpty
        && viewModel.email.contains("@")
        && !viewModel.password.isEmpty
        && viewModel.password.count > 8
    }
}

#Preview {
    LogInView()
}
