//
//  ChatLogView.swift
//  test
//
//  Created by Jhanavi Thakkar on 11/6/23.
//

import SwiftUI
import Firebase


class ChatLogViewModel: ObservableObject{
    
    @Published var chatText = ""
    
    //array of messages 
    @Published var chatMessages = [ChatMessage]()
    
    @Published var chatUser: ChatUser?
    
    init(chatUser: ChatUser?){
        self.chatUser = chatUser
        
        //get all the messages to/from that user to popular the chat Log
        fetchMessages()
    }
    
     func fetchMessages(){
        guard let fromId = Auth.auth().currentUser?.uid else {return}
        
        //recepient
        guard let toId = chatUser?.uid else {return}
        
        Firestore.firestore().collection("messages")
            .document(fromId)
            .collection(toId)
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                if let error = error{
                    print("Failed to listen for messages: \(error)")
                    return
                }
                
                //fetch the current messages between the two users ignorning repeats
                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .added{
                        let data = change.document.data()
                        self.chatMessages.append(.init(documentId: change.document.documentID, data: data))
                    }
                })
                
                //to help with autoscroll to bottom of chat functionality
                DispatchQueue.main.async {
                    self.count += 1
                }
                
            }
    }
    
    func handleSend(){
        print(chatText)
        //user you are sending from, ie current user
        guard let fromId = Auth.auth().currentUser?.uid else {return}
        
        //recepient
        guard let toId = chatUser?.uid else {return}
        
        //save message to firestore
        let document =
        Firestore.firestore().collection("messages")
            .document(fromId)
            .collection(toId)
            .document()
        
        let messageData = [FirebaseConstants.fromId: fromId, FirebaseConstants.toId: toId, FirebaseConstants.text: chatText, "timestamp": Timestamp()] as [String: Any]
        
        document.setData(messageData) { error in
            if let error = error {
                print("Failed to save message into Firestore: \(error)")
                return
            }
            
            print("Successfully saved current user sending message")
            
            self.persistRecentMessage()
            
            self.chatText = ""
            
            self.count += 1
        }
        
        //need to save same message on recipient side
        let recipientMessageDocument =
        Firestore.firestore().collection("messages")
            .document(toId)
            .collection(fromId)
            .document()
        
        recipientMessageDocument.setData(messageData) { error in
            if let error = error {
                print("Failed to save message into Firestore: \(error)")
                return
            }
            
            print("Recipient saved message too")
        }
    }
    
    private func persistRecentMessage() {
        
        guard let chatUser = chatUser else {return}
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        guard let toId = self.chatUser?.uid else {return}
        
        let document = Firestore.firestore()
            .collection("recent_messages")
            .document(uid)
            .collection("messages")
            .document(toId)
        
        let data = [
            FirebaseConstants.timestamp: Timestamp(),
            FirebaseConstants.text: self.chatText,
            FirebaseConstants.fromId: uid,
            FirebaseConstants.toId: toId,
            FirebaseConstants.profileImageURL: chatUser.profileImageURL,
            FirebaseConstants.email: chatUser.email,
            FirebaseConstants.name: chatUser.name
        ] as [String : Any]
        
        document.setData(data) { error in
            if let error = error {
                print("Failed to save recent message: \(error)")
                return
            }
        }
        
        //NEED TO DO AGAIN FOR RECIPIENT ^
        
        guard let currentUser = FirebaseManager.shared.currentUser else { return }
        let recipientRecentMessageDictionary = [
            FirebaseConstants.timestamp: Timestamp(),
            FirebaseConstants.text: self.chatText,
            FirebaseConstants.fromId: uid,
            FirebaseConstants.toId: toId,
            FirebaseConstants.profileImageURL: currentUser.profileImageURL,
            FirebaseConstants.email: currentUser.email,
            FirebaseConstants.name: currentUser.name
        ] as [String : Any]
        
        Firestore.firestore()
            .collection("recent_messages")
            .document(toId)
            .collection("messages")
            .document(currentUser.uid)
            .setData(recipientRecentMessageDictionary) { error in
                if let error = error {
                    print("Failed to save recipient recent message: \(error)")
                    return
                }
            }
        
    }
    
    @Published var count = 0
}

struct ChatLogView: View {
    
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?){
        self.chatUser = chatUser
        self.vm = .init(chatUser: chatUser)
    }
    
    @ObservedObject var vm : ChatLogViewModel
    
    var body: some View{
        
        VStack{
            messagesView
            
            chatBottomBar
        }
        
        .navigationTitle(chatUser?.name ?? "")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private var messagesView: some View{
        ScrollView{
            ScrollViewReader { scrollViewProxy in
                VStack{
                    ForEach(vm.chatMessages){ message in
                        MessageView(message: message)
                    }
                    
                    HStack{
                        Spacer()
                    }
                    .id("Empty")
                }
                .onReceive(vm.$count) { _ in
                    withAnimation(.easeOut(duration: 0.5)) {
                        scrollViewProxy.scrollTo("Empty", anchor: .bottom)
                    }
                    
                }
                
            }
            
        }
        .background(Color(.init(white: 0.95, alpha: 1)))
    }
    
    private var chatBottomBar: some View {
        HStack(spacing: 16){

            ZStack {
                DescriptionPlaceholder()
                TextEditor(text: $vm.chatText)
                    .opacity(vm.chatText.isEmpty ? 0.5 : 1)
            }
            .frame(height: 40)
            Button {
                vm.handleSend()
            } label: {
                Text("Send")
                    .foregroundColor(Color.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(CustomColor.myColor)
            .cornerRadius(4)

        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        
    }
}

struct MessageView: View {
    
    let message: ChatMessage
    var body: some View{
        VStack{
            //depending on the fromId, message will be green or white
            if message.fromId == Auth.auth().currentUser?.uid {
                HStack{
                    Spacer()
                    HStack{
                        Text(message.text)
                            .foregroundColor(Color.white)
                    }
                    .padding()
                    .background(CustomColor.myColor)
                    .cornerRadius(8)
                }
            } else {
                HStack{
                    HStack{
                        Text(message.text)
                            .foregroundColor(Color.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                     
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

private struct DescriptionPlaceholder: View {
    var body: some View {
        HStack {
            Text("Message...")
                .foregroundColor(Color(.gray))
                .font(.system(size: 17))
                .padding(.leading, 5)
                .padding(.top, -4)
            Spacer()
        }
    }
}

#Preview {
    NavigationView{
        MainMessagesView()
    }
}
