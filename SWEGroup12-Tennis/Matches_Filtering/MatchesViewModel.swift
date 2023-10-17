//
//  MatchesViewModel.swift
//  SWEGroup12-Tennis
//
//  Created by Kathleen Katchis on 10/15/23.
//

import Foundation
import FirebaseFirestore

class MatchesViewModel: ObservableObject {
    @Published var matches = [Match]()
    
    //function connects to firestore and gets changes to books
    private var db = Firestore.firestore()
    
    func fetchData(){
        db.collection("users").addSnapshotListener{ (QuerySnapshot, error) in guard let documents = QuerySnapshot?.documents else {
            print("No Documents")
            return
        }
            
            self.matches = documents.map { (QueryDocumentSnapshot) in
            let data = QueryDocumentSnapshot.data()
                
            if let name = data["fullname"] as? String,
               let skillLevel = data["skillLevel"] as? String,
               let email = data["email"] as? String,
                let gender = data["gender"] as? String,
                let type = data["type"] as? String{
                let match = Match(name: name,  skillLevel: skillLevel, email:email, gender:gender, type:type)
                return match
            }else{
                return Match(name: "N/A", skillLevel: "N/A", email:"N/A", gender:"N/A", type:"N/A")
            }
            }
        }
    }
    
}
