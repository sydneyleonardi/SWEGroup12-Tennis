//
//  CreateNewMessageView.swift
//  test
//
//  Created by Jhanavi Thakkar on 11/6/23.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

class CreateNewMessageViewModel: ObservableObject{
    
    @Published var users = [ChatUser]()
    @Published var errorMessage = ""
    
    init(){
        fetchAllUsers()
    }
    
    private func fetchAllUsers(){
        Firestore.firestore().collection("users")
            .getDocuments { documentsSnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch users: \(error)"
                    print("Failed to fetch users: \(error)")
                    return
                }
                
                documentsSnapshot?.documents.forEach({ snapshot in
                    let data = snapshot.data()
                    self.users.append(.init(data: data))
                })
                
               // self.errorMessage = "Fetched users successfully"
            }
    }
}

struct CreateNewMessageView: View {
    
    //to keep track of selected new user to message
    let didSelectNewUser: (ChatUser) -> ()
    
    //used for cancel button functionality
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var vm = CreateNewMessageViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                Text(vm.errorMessage)
                ForEach(vm.users){user in
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        didSelectNewUser(user)
                    } label: {
                        HStack(spacing: 16){
                            WebImage(url: URL(string: user.profileImageURL))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipped()
                                .cornerRadius(50)
                                .overlay(RoundedRectangle(cornerRadius: 44)
                                    .stroke(Color(.label), lineWidth: 1)
                                )
                            
                            Text(user.name)
                                .foregroundColor(Color(.label))
                            Spacer()
                        }.padding(.horizontal)
                    }
                    Divider()
                        .padding(.vertical, 9)

                }
            }.navigationTitle("New Message")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Cancel")
                        }

                    }
                }
        }
    }
}

#Preview {
//    CreateNewMessageView()
    MainMessagesView()
}
