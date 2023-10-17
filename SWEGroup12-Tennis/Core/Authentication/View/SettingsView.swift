//
//  SettingsView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/15/23.
//


// TO DO
// Get Update Password to work + get an alert
// If time, fix the info at the top

import SwiftUI
import FirebaseAuth

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published private(set) var user: AuthDataResultModel? = nil
    @Published private(set) var dataUser: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthManager.shared.fetchUser()
        self.user = authDataResult
        self.dataUser = try await UserManager.shared.getUser(userId: authDataResult.uid)
        
    }
    
    func signOut() throws {
        try AuthManager.shared.signOut()
    }
    
    func updatePassword() async throws {
        let password = "password"
        try await AuthManager.shared.updatePassword(newPassword: password)
    }
    
    func deleteAccount() throws {
        try AuthManager.shared.deleteAccount()
        try UserManager.shared.deleteUserData(uid: dataUser?.userId ?? "")
    }
    
}

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignIn: Bool
    @Environment(\.dismiss) var dismiss
    @State private var alert = false
    
    var body: some View {
        
        let user = viewModel.user
        let dataUser = viewModel.dataUser
        
        List{
            Section("Account Settings"){
                Button{
                    Task{
                        do{
                            try viewModel.signOut()
                            dismiss()
                            showSignIn = true
                        }catch{
                            print(error)
                        }
                    }
                }label:
                {
                    SettingsRowView(imageName:"arrow.left.circle.fill", title: "Log Out", tintColor: .red)
                }
                
                Button{
                    Task{
                        do{
                            try await viewModel.updatePassword()
                            print("Password Updated")
                        }catch{
                            print(error)
                        }
                    }
                }label:{
                    SettingsRowView(imageName:"lock.circle.fill", title: "Update Password", tintColor: .red)
                }
                
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
                    SettingsRowView(imageName:"xmark.circle.fill", title: "Delete Account", tintColor: .red)
                }
            }
        }
        .onAppear{
            Task{
                try? await viewModel.loadCurrentUser()
            }
        }
        .alert(isPresented: $alert) {
            Alert(title: Text("Account Deleted"),
                  message: Text("Your account was successfully deleted"),
                  dismissButton: .default(Text("OK")) {
                alert = false
                dismiss()
                showSignIn = true
            })
        }
    }
}

#Preview {
    SettingsView(showSignIn: .constant(false))
}
