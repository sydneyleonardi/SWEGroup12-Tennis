//
//  ContentView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 9/27/23.
//

import SwiftUI

struct CustomColor{
    static let myColor = Color("Color")
}

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.white
                    .ignoresSafeArea()
                VStack{
                    // Logo at the top of the screen
                    Image("Logo")
                    
                    // Name of the appp
                    Text("Get Matched.")
                        .font(.largeTitle)
                        .padding()
                    
                    // Username
                    TextField("Username", text: $username)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(Color.red, width: CGFloat(wrongUsername))
                    
                    // Password
                    SecureField("Password", text: $password)
                        .autocorrectionDisabled(true)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(Color.red, width: CGFloat(wrongPassword))
                    
                    Button("Forgot your password?")
                    {
                        // What happens when you forget your password
                    }
                        .font(.caption)
                        .foregroundColor(Color.blue)
                        .padding()
                    
                    
                    // Login Button
                    Button("Login")
                    {
                        authenticateUser(username: username, password: password)
                        
                    }
                    .foregroundColor(.white)
                    .bold()
                    .frame(width:300, height:50)
                    .background(CustomColor.myColor)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: Text("Welcome @\(username) to Get Matched"),
                                   isActive: $showingLoginScreen)
                    {
                        EmptyView()
                    }
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func authenticateUser(username: String, password: String)
    {
        
          // ...
        if(username.lowercased() == "sydneyleonardi"){
            wrongUsername = 0
            if(password.lowercased() == "isthebest")
            {
                wrongPassword = 0
                showingLoginScreen = true
            } else {
                wrongPassword = 2
            }
        } else {
            wrongUsername = 2
        }
    }
}

#Preview {
    ContentView()
}
