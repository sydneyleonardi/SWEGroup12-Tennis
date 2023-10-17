//
//  MatchesViewModel.swift
//  SWEGroup12-Tennis
//
//  Created by Kathleen Katchis on 10/15/23.
//

import Foundation
import FirebaseFirestore

class MessagingViewModel: ObservableObject {
    @Published var messages = [Message]()
    
    //function connects to firestore and gets changes to books
    private var db = Firestore.firestore()
    
    func fetchData(){
        db.collection("messages").addSnapshotListener{ (QuerySnapshot, error) in guard let documents = QuerySnapshot?.documents else {
            print("No Documents")
            return
        }
            
            self.messages = documents.map { (QueryDocumentSnapshot) in
            let data = QueryDocumentSnapshot.data()
                
            if let name = data["name"] as? String,
               let message = data["message"] as? String{
                let messages = Message(name: name,  message: message)
                return messages
            }else{
                return Message(name: "N/A", message: "N/A")
            }
            }
        }
    }
    
}
