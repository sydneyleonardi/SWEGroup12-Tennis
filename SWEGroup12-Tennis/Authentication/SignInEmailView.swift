//
//  SignInEmailView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 9/28/23.
//
/*
import SwiftUI

final class SignInEmailViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    
    func signIn()
    {
        guard !email.isEmpty, !password.isEmpty else {
            // Here is where you would do validation, want to make passwords difficult
            print("No email or password found.")
            return
        }
        Task {
            do{
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
                print(returnedUserData)
            }
            catch{
                print("Error!")
            }
        }
    }
}

struct SignInEmailView: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    var body: some View {
        VStack{
            Image("Logo")
                .padding()
            
            Text("Get Matched.")
                .font(.largeTitle)
                .padding()
            
            TextField("Email", text: $viewModel.email)
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
                .padding()
                .frame(width:300, height:50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                
            
            SecureField("Password", text: $viewModel.password)
                .autocorrectionDisabled(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .padding()
                .frame(width:300, height:50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
            
            Button{
                viewModel.signIn()
            }label: {
                Text("Sign In")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(CustomColor.myColor)
                    .cornerRadius(10)
                    .padding()
            }
        }
    }
}

#Preview {
    NavigationStack{
        SignInEmailView()
    }
}
*/
