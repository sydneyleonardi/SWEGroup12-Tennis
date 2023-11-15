//
//  SettingsView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/15/23.
//


import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var alert = false
    @State private var showSignIn = false
    
    var body: some View {
        
        VStack{
            Text("Settings")
                .font(.headline)
                .frame(alignment: .leading)
                .padding(.bottom, 30)
        }
        
        
        VStack{
            
            HStack{
                Text("Login")
                    .bold()
                    .font(.subheadline)
                    .padding(.leading, 50)
                
                Spacer()
            }
            
            // Update Password
            NavigationLink{
                UpdatePasswordView()
            }label:{
                SettingsRowView(imageName:"lock.circle.fill", title: "Update Password", tintColor: .black)
            }
            .frame(width:300, height:50, alignment: .leading)
            .padding(.leading, 10)
            .background(CustomColor.myColor)
            .cornerRadius(10)
            .padding(.bottom,10)
            
            // Sign User Out
            Button{
                Task{
                    do{
                        try viewModel.signOut()
                        showSignIn = true
                    }catch{
                        print(error)
                    }
                }
            }label:
            {
                SettingsRowView(imageName:"arrow.left.circle.fill", title: "Log Out", tintColor: .black)
            }
            .frame(width:300, height:50, alignment: .leading)
            .padding(.leading, 10)
            .background(CustomColor.myColor)
            .cornerRadius(10)
            .padding(.bottom,10)
            
            
            
            HStack{
                Text("Account")
                    .bold()
                    .font(.subheadline)
                    .padding(.leading, 50)
                
                Spacer()
            }
            // Delete User's Account
            Button{
                Task{
                    do{
                        try viewModel.deleteAccount()
                        alert = true
                    }catch{
                        print(error)
                    }
                }
            }label:{
                SettingsRowView(imageName:"xmark.circle.fill", title: "Delete Account", tintColor: .black)
            }
            .frame(width:300, height:50, alignment: .leading)
            .padding(.leading, 10)
            .background(CustomColor.myColor)
            .cornerRadius(10)
            .padding(.bottom,10)
            
            HStack{
                Text("Information")
                    .bold()
                    .font(.subheadline)
                    .padding(.leading, 50)
                
                Spacer()
            }
            
            Link(destination:URL(string: "https://sites.google.com/vanderbilt.edu/vandycourtsprivacypolicy/home")!)
            {
                HStack
                {
                    Image(systemName: "lock.doc.fill")
                        .imageScale(.small)
                        .font(.title)
                    Text("Privacy Policy")
                }
                .padding(.leading, 10)
                .frame(width:310, height: 50, alignment:.leading)
                .background(CustomColor.myColor)
                .cornerRadius(10)
                .foregroundColor(.black)
                .padding(.bottom, 10)
            }
            
            Link(destination:URL(string: "https://sites.google.com/vanderbilt.edu/vandycourtshelp/home")!)
            {
                HStack
                {
                    Image(systemName: "info.circle.fill")
                        .imageScale(.small)
                        .font(.title)
                    Text("Help")
                }
                .padding(.leading, 10)
                .frame(width:310, height: 50, alignment:.leading)
                .background(CustomColor.myColor)
                .cornerRadius(10)
                .foregroundColor(.black)
            }
            
            Spacer()
        }
        .onAppear{
            Task{
                try? await viewModel.loadCurrentUser()
            }
        }
        
        // alert when error occurs
        // adjust to demonstrate what error is occuring
        .alert(isPresented: $alert) {
            Alert(title: Text("Account Deleted"),
                  message: Text("Your account was successfully deleted"),
                  dismissButton: .default(Text("OK")) {
                alert = false
                showSignIn = true
            })
        }
        
        // Navigates back to Log In View
        NavigationLink("", destination: LogInView().navigationBarBackButtonHidden(true), isActive: $showSignIn)
    }

}

#Preview {
    SettingsView()
}
