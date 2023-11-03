//
//  CalendarResManager.swift
//  SWEGroup12-Tennis
//
//  Created by Sophia Fayer on 10/31/23.
//

import Foundation
import FirebaseFirestore

struct Res: Identifiable, Equatable {
    var id: String
    var court: String
    var start: String
    var end: String
    var date: String
    var reserved: Bool
    var player: String
}

// Using Model View Architecture

class ResViewModel: ObservableObject {
    @Published var reservations = [Res]()
    
    private var db = Firestore.firestore()
    
    //grab reservation data from firestore db
    func fetchRes(courtNum: String) {

        //adjust path based on court number
        let path = "courtReservations/court" + courtNum + "/court" + courtNum + "Reservations"
        
        db.collection(path).addSnapshotListener { (querySnapshot, error) in
            guard let docs1 = querySnapshot?.documents else {
                print("Documents not found")    //handle db reading error
                return
            }
            
            //read data from firebase for Reservation objects
            self.reservations = docs1.map { QueryDocumentSnapshot -> Res in
                let data = QueryDocumentSnapshot.data()
                let start = data["start"] as? String ?? ""
                let end = data["end"] as? String ?? ""
                let id = data["id"] as? String ?? ""
                let date = data["date"] as? String ?? ""
                let reserved = data["reserved"] as? Bool ?? false
                let player = data["player"] as? String ?? ""
                
                return Res(id: id, court: courtNum, start: start, end: end, date: date, reserved: reserved, player: player)
            }
        }
    }
    
    //updates reservation with player, player's id, and sets the boolean value "reserved" to true
    func makeRes(id: String, player: String, courtNum: String){
        
        let path = "courtReservations/court" + courtNum + "/court" + courtNum + "Reservations"
        
        //include player id
        db.collection(path).document(id).updateData(["reserved":true, "player": player]) {error in
            if let error = error{
                print("Error updating document :\(error)") //handle db writing error
            }
            else{
                print("updated document") //successful write to db
            }
        }
        
        
    }
    
    func deleteRes(id: String, courtNum: String){
        let path = "courtReservations/court" + courtNum + "/court" + courtNum + "Reservations"
        
        db.collection(path).document(id).updateData(["reserved":false, "player": "", "playerID": ""]) {error in
            if let error = error{
                print("Error updating document :\(error)") //handle db writing error
            }
            else{
                print("updated document") //successful write to db
            }
        }
    }
    
    //block players from scheduling more than one res at a time
    
}





