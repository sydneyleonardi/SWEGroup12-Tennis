//
//  LogInView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/15/23.
//

// TO DO
// Fix error + authentication rules + alerts 

import SwiftUI


@MainActor
final class LogInEmailViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var errorAlert = false
    
    func signIn() async throws {
        
        try await AuthManager.shared.signInUser(email: email, password: password)
        }
}

struct LogInView: View {
    @StateObject private var viewModel = LogInEmailViewModel()
    @Binding var showSignIn: Bool
    @Binding var showCreateUser: Bool
    
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
                    ForgottenPasswordView(showSignIn: $showSignIn)
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
                            showSignIn = false
                            return
                        }catch{
                            viewModel.errorAlert = true
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
                .alert(isPresented: $viewModel.errorAlert) {
                    Alert(title: Text("Invalid Login"),
                          message: Text("Email and/or password are invalid"),
                          dismissButton: .default(Text("OK")) {
                        viewModel.errorAlert = false
                        viewModel.email = ""
                        viewModel.password = ""
                    })
                }


                
                
                // Sign Up Instead 
                NavigationLink{
                    SignUpView(showSignIn: $showSignIn, showCreateUser: $showCreateUser)
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

extension LogInView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !viewModel.email.isEmpty
        && viewModel.email.contains("@")
        && !viewModel.password.isEmpty
        && viewModel.password.count > 8
    }
}

#Preview {
    LogInView(showSignIn: .constant(false), showCreateUser: .constant(false))
}
