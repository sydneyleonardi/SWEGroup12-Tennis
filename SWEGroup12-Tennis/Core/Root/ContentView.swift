//
//  ContentView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 9/27/23.
//

// TO DO
// Fix the navigation hierarchy 

import SwiftUI
import FirebaseAuth

struct CustomColor{
    static let myColor = Color("Color")
}

struct ContentView: View {
    
    @State private var showSignIn: Bool = false
    @State private var showCreateUser: Bool = false
    
    var body: some View {
        ZStack{
            NavigationStack{
                if(showCreateUser == false)
                {
                    ProfileView(showSignIn: $showSignIn)
                }
                else{
                    CreateProfileView(showSignIn: $showSignIn, showCreateUser: $showCreateUser)
                }
            }
        }
        .onAppear {
            let authUser = try? AuthManager.shared.fetchUser()
            self.showSignIn = authUser == nil
            
        }
        .fullScreenCover(isPresented: $showSignIn){
            NavigationStack{
                LogInView(showSignIn: $showSignIn, showCreateUser: $showCreateUser)
            }
        }
    }
}

#Preview {
    ContentView()
}
