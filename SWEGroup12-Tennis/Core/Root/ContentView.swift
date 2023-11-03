//
//  ContentView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 9/27/23.
//


import SwiftUI
import FirebaseAuth

struct CustomColor{
    static let myColor = Color("Color")
}

struct ContentView: View {
    
    // If user has already signed in on device, will take them straight to profile
    @State private var userIsSignedIn: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                if(userIsSignedIn){
                    HomeView()
                }else{
                    SignUpView()
                }
            }
        }
        .onAppear {
            let authUser = try? AuthManager.shared.fetchUser()
            self.userIsSignedIn = authUser != nil
        }
    }
}

#Preview {
    ContentView()
}
