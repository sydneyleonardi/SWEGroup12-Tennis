//
//  SettingsView.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 10/15/23.
//


// TO DO
// Get Update Password to work + get an alert
// Get an alert when you delete account
// If time, fix the info at the top

import SwiftUI
import FirebaseAuth

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published private(set) var user: AuthDataResultModel? = nil
    
    func loadCurrentUser() throws {
        self.user = try AuthManager.shared.fetchUser()
        
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
    }
    
}

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignIn: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        let user = viewModel.user
        
        List{
            /*
            Section{
                    HStack {
                        Text("SL")
                            .font(.title)
                            .fontWeight(.semibold)
                            .frame(width: 72, height: 72)
                            .foregroundColor(.white)
                            .background(Color(.systemGray))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4){
                            Text(user?.name ?? "")
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            Text(user?.email ?? "")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }
                */
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
                                showSignIn = true
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
            try? viewModel.loadCurrentUser()
        }
        }
   }

#Preview {
    SettingsView(showSignIn: .constant(false))
}
