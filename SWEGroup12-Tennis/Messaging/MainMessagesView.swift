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
    @Published var chatUser: ChatUser?
//    = ChatUser(data: ["id": "", "email": "", "profileImageURL": "", "name": "", "gender": "", "age": "", "skillLevel": "", "type": "","description": "","datesSelected": []])
    
    init(){
        fetchCurrentUser()
        
        fetchRecentMessages()
    }
    
    @Published var recentMessages = [RecentMessage]()
    
    
     func fetchRecentMessages(){
        guard let uid = Auth.auth().currentUser?.uid else{return}
         
         //removes obsilete messages
         self.recentMessages.removeAll()
        
        Firestore.firestore().collection("recent_messages")
            .document(uid)
            .collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Failed to listen for recent messages: \(error)")
                    return
                }
                
                querySnapshot?.documentChanges.forEach({ change in
                    
                    let docId = change.document.documentID
                    
                    if let index =
                        self.recentMessages.firstIndex(where: { rm in
                        return rm.documentId == docId
                        }){
                        self.recentMessages.remove(at:index)
                    }
                    
                    self.recentMessages.insert(.init(documentId: docId, data: change.document.data()), at: 0)
                        
//                    self.recentMessages.append(.init(documentId: docId, data: change.document.data()))
                    
                })
            }
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
    
    private var chatLogViewModel = ChatLogViewModel(chatUser: nil)
    
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
            
            WebImage(url: URL(string: vm.chatUser?.profileImageURL ?? "person.fill"))
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipped()
                .cornerRadius(64)
                .overlay(RoundedRectangle(cornerRadius: 44)
                    .stroke(Color.black, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/))
            
            //Image(systemName: "person.fill").font(.system(size: 34, weight: .heavy))
            
            VStack(alignment: .leading, spacing: 4){
                Text(vm.chatUser?.name ?? "").font(.system(size: 24, weight: .bold))
                HStack{
                    Circle().foregroundColor(.green).frame(width: 14, height: 14)
                    Text("online").font(.system(size: 14)).foregroundColor(Color(.lightGray))
                }
            }
            Spacer()
        }
        .padding()
    }
    
    
    private var messagesView: some View {
        ScrollView{
            ForEach(vm.recentMessages){recentMessage in
                VStack{
                    Button {
                        let uid = Auth.auth().currentUser?.uid == recentMessage.fromId ? recentMessage.toId : recentMessage.fromId
                        self.chatUser = ChatUser(data: ["id": uid, "uid": uid, "email": recentMessage.email, "profileImageURL": recentMessage.profileImageURL, "name": recentMessage.name, "gender": "", "age": "", "skillLevel": "", "type": "","description": "","datesSelected": []])
                        self.chatLogViewModel.chatUser = self.chatUser
                        self.chatLogViewModel.fetchMessages()
                        self.shouldNavigateToChatLogView.toggle()
                    } label: {
                        HStack(spacing: 16){
                            WebImage(url: URL(string: recentMessage.profileImageURL))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipped()
                                .cornerRadius(64)
                                .overlay(RoundedRectangle(cornerRadius: 44)
                                    .stroke(Color.black, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/))
                            
                            
                            VStack(alignment: .leading, spacing: 8){
                                Text(recentMessage.name).font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color(.label))
                                Text(recentMessage.text).font(.system(size: 14)).foregroundColor(Color(.darkGray))
                                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            }
                            
                            Spacer()
                            
                            Text(recentMessage.timeAgo).font(.system(size: 14, weight: .semibold))
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

