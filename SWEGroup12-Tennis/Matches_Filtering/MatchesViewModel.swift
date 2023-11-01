//
//  MatchesViewModel.swift
//  SWEGroup12-Tennis
//
//  Created by Kathleen Katchis on 10/15/23.
//

import Foundation
import FirebaseFirestore

class MatchesViewModel: ObservableObject {
    //varibales to store the matched pulled from DB and to send pop up alert when quick match is invoked
    @Published var matches = [Match]()
    @Published var alert = false
    
    //function connects to firestore and gets changes to books
    private var db = Firestore.firestore()
    
    func fetchData(){
        //pull all users
        db.collection("users").addSnapshotListener{ (QuerySnapshot, error) in guard let documents = QuerySnapshot?.documents else {
            print("No Documents")
            return
        }
            
            self.matches = documents.map { (QueryDocumentSnapshot) in
            let data = QueryDocumentSnapshot.data()
                //verify correct data is pulled for each user
            if let name = data["name"] as? String,
               let skillLevel = data["skillLevel"] as? String,
               let email = data["email"] as? String,
                let gender = data["gender"] as? String,
                let type = data["type"] as? String{
                let match = Match(name: name,  skillLevel: skillLevel, email:email, gender:gender, type:type)
                return match
            }else{
                //send match data to MatchedListView
                return Match(name: "N/A", skillLevel: "N/A", email:"N/A", gender:"N/A", type:"N/A")
            }
            }
        }
    }
    
}
