//
//  LogInView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/15/23.
//

import SwiftUI

struct LogInView: View {
    @StateObject private var viewModel = LogInEmailViewModel()
    //@State private var error: LogInEmailViewModel.VerificationError?
    
    // error messages
    @State private var errorAlert = false
    @State private var errorMessage = ""
    
    // navigation variable
    @State private var showProfile = false
    @State private var showPopUp = false
    
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
                Text("Vandy Tennis")
                    .font(.largeTitle)
                
                // Text Fields for Email + Password
                VStack(spacing:15){
                    InputView(text: $viewModel.email, title: "Email")
                    
                    ZStack(alignment: .trailing){
                        InputView(text: $viewModel.password, title: "Password", isSecureField: true)
                        
                        Button
                        {
                           showPopUp = true
                        }label:{
                            Image(systemName: "info.circle")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGray))
                                .padding(.trailing, 5)
                        }
                        .popover(isPresented:$showPopUp){
                            VStack{
                                Text("Password must be greater than 8 characters")
                            }
                            .presentationCompactAdaptation(.popover)
                        }
                    
                    }
                    
                    
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
                        }catch LogInEmailViewModel.VerificationError.notVerified{
                            errorMessage = "This account is not yet verified. Check your email to verify your account."
                            errorAlert = true
                        }catch{
                            errorMessage = "Email and/or password are invalid"
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
                    Alert(title: Text(errorMessage),
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
