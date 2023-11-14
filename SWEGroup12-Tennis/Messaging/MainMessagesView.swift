//
//  MainMessagesView.swift
//  test
//
//  Created by Jhanavi Thakkar on 10/22/23.
//

import SwiftUI
import Firebase
import FirebaseStorage
import SDWebImageSwiftUI

class MainMessagesViewModel: ObservableObject{
    
    @Published var errorMessage = ""
    @Published var chatUser = ChatUser(data: ["id": "", "email": "", "profileImageURL": "", "name": "", "gender": "", "age": "", "skillLevel": "", "type": "","description": "","datesSelected": []])
    
    init(){
        fetchCurrentUser()
    }
    
    private func fetchCurrentUser(){
        self.errorMessage = "Fetching Current user"
        guard let uid = Auth.auth().currentUser?.uid
        else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        
        
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if let error = error{
                
                self.errorMessage = "Failed to fetch current user: \(error)"
                print("Failed to fetch current user:", error)
                return
            }
            
            //data dictionary to exract exact info from database
            guard let data = snapshot?.data() else {return}
            
            self.errorMessage = "Data; \(data.description)"
            //print(data.description)
            
            let uid = data["id"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let profileImageUrl = data["profileImageURL"] as? String ?? ""
            let name = data["name"] as? String ?? ""
            let gender = data["gender"] as? String ?? ""
            let age = data["age"] as? String ?? ""
            let skillLevel = data["skillLevel"] as? String ?? ""
            let playType = data["type"] as? String ?? ""
            let description = data["description"] as? String ?? ""
            let datesSelected = data["datesSelected"] as? Array<Int> ?? []
            
            self.chatUser = ChatUser(data: ["id": uid, "email": email, "profileImageURL": profileImageUrl, "name": name, "gender": gender, "age": age, "skillLevel": skillLevel, "type": playType,"description": description,"datesSelected": datesSelected])
            
            FirebaseManager.shared.currentUser = self.chatUser
        }
    }
}


struct MainMessagesView: View {
    
    @State var shouldShowLogOutOptions = false;
    
    @State var shouldNavigateToChatLogView = false;
    
    
    //creating an instance of the viewmodel
    @ObservedObject private var vm = MainMessagesViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                
                //Text("CURRENT USER ID: \(vm.errorMessage)")
                customNavBar
                messagesView
                
                NavigationLink("", isActive: $shouldNavigateToChatLogView){
                    ChatLogView(chatUser: self.chatUser)
                }
                
            }
            .overlay(newMessageButton, alignment: .bottom)
            .navigationBarHidden(true)
        }
    }
    
    private var customNavBar: some View {
        
        HStack(spacing: 16){
            
            WebImage(url: URL(string: vm.chatUser.profileImageURL ?? "person.fill"))
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipped()
                .cornerRadius(64)
                .overlay(RoundedRectangle(cornerRadius: 44)
                    .stroke(Color.black, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/))
            
            //Image(systemName: "person.fill").font(.system(size: 34, weight: .heavy))
            
            VStack(alignment: .leading, spacing: 4){
                Text(vm.chatUser.name ?? "").font(.system(size: 24, weight: .bold))
                HStack{
                    Circle().foregroundColor(.green).frame(width: 14, height: 14)
                    Text("online").font(.system(size: 14)).foregroundColor(Color(.lightGray))
                }
            }
            Spacer()
//            Button {
//                shouldShowLogOutOptions.toggle()
//            } label: {
//                Image(systemName: "gear")
//                    .font(.system(size: 24, weight: .bold))
//            }
        }
        .padding()
//        .actionSheet(isPresented: $shouldShowLogOutOptions) {
//            .init(title: Text("Settings"), message: Text("What do you want to do?"), buttons: [.default(Text("Default Button")), .cancel()])
//        }
    }
    
    
    private var messagesView: some View {
        ScrollView{
            ForEach(0..<10, id: \.self){num in
                VStack{
                    NavigationLink {
                        Text("Destination")
                    } label: {
                        HStack(spacing: 16){
                            Image(systemName: "person.fill")
                                .font(.system(size: 32))
                                .padding(8)
                                .overlay(RoundedRectangle(cornerRadius: 44)
                                    .stroke(Color.black, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/))
                            
                            
                            VStack(alignment: .leading){
                                Text("Username").font(.system(size: 16, weight: .bold))
                                Text("Message sent to user").font(.system(size: 14)).foregroundColor(Color(.lightGray))
                            }
                            
                            Spacer()
                            
                            Text("22d").font(.system(size: 14, weight: .semibold))
                        }
                    }


                    Divider()
                        .padding(.vertical, 8)
                }.padding(.horizontal)
                
            }.padding(.bottom, 50)
            
        }
    }
    
    @State var shouldShowNewMessageScreen = false
    
    private var newMessageButton: some View {
        Button{
            shouldShowNewMessageScreen.toggle()
        }label: {
            HStack{
                Spacer()
                Text("+ New Message")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.vertical)
            .background(CustomColor.myColor)
                .cornerRadius(32)
                .padding(.horizontal)
                .shadow(radius: 15)
        }
        .fullScreenCover(isPresented: $shouldShowNewMessageScreen){
            CreateNewMessageView(didSelectNewUser: { user in
                print(user.email)
                self.shouldNavigateToChatLogView.toggle()
                self.chatUser = user
            })
        }
    }
    
    //state is optional nil bc no user selected at beginning
    @State var chatUser: ChatUser?
}


#Preview {
    MainMessagesView()
}
