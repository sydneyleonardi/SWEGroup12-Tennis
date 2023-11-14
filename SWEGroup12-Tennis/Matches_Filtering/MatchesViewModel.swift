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
    var db = Firestore.firestore()
    
    func fetchData(){
        //pull all users
        db.collection("users").addSnapshotListener{ (QuerySnapshot, error) in guard let documents = QuerySnapshot?.documents else {
            print("No Documents")
            return
        }
            
            self.matches = documents.map { (QueryDocumentSnapshot) in
            let data = QueryDocumentSnapshot.data()
                //verify correct data is pulled for each user
            if let userID = data["id"] as? String,
                let name = data["name"] as? String,
               let skillLevel = data["skillLevel"] as? String,
                let gender = data["gender"] as? String,
                let type = data["type"] as? String,
               let time = data["datesSelected"] as? [Int]{
                let match = Match(userID: userID , name: name, skillLevel: skillLevel, gender:gender, type:type, time:time)
                return match
            }else{
                //send match data to MatchedListView
                return Match(userID:"N/A", name: "N/A", skillLevel: "N/A", gender:"N/A", type:"N/A", time: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
            }
            }
        }
    }
    func filterMatches(match: Match, sendFilter: Match, currUser: String, currTime: [Int]) -> Bool {
        return (sendFilter.gender.isEmpty || match.gender == sendFilter.gender) &&
               (sendFilter.skillLevel.isEmpty || match.skillLevel == sendFilter.skillLevel) &&
               (sendFilter.type.isEmpty || match.type == sendFilter.type) &&
               (currUser != match.name) &&
               arraysHaveCommonTime(currTime: currTime, matchTime: match.time)
    }
    func arraysHaveCommonTime(currTime: [Int], matchTime: [Int]) -> Bool {
        for (curr, match) in zip(currTime, matchTime) {
            if curr == 1 && match == 1 {
                return true
            }
        }
        return false
    }
    
}
