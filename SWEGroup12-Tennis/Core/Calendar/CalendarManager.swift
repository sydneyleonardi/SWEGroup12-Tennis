//
//  CalendarManager.swift
//  SWEGroup12-Tennis
//
//  Created by Sophia Fayer on 10/9/23.
//

import Foundation
import FirebaseFirestore

struct Reservation: Identifiable {
    var id: String = UUID().uuidString
    var day: Int
    var month: Int
    var year: Int
    var start: String
    var end: String
    var date: String
    var reserved: Bool
    var player: String
}

//Using Model View Architecture

class ReservationsViewModel: ObservableObject {
    @Published var reservations = [Reservation]()
    
    private var database = Firestore.firestore()
    
    //grab data from firestore db (including day, month, year, and start time)
    func fetchReservations() {
        database.collection("reservations").addSnapshotListener { (querySnapshot, error) in
            guard let docs = querySnapshot?.documents else {
                print("Documents not found")    //handle db reading error
                return
            }
            
            //read data from firebase for Reservation objects
            self.reservations = docs.map { QueryDocumentSnapshot -> Reservation in
                let data = QueryDocumentSnapshot.data()
                let day = data["day"] as? Int ?? 0
                let month = data["month"] as? Int ?? 0
                let year = data["year"] as? Int ?? 0
                let start = data["start"] as? String ?? ""
                let end = data["end"] as? String ?? ""
                let id = data["id"] as? String ?? ""
                let date = data["date"] as? String ?? ""
                let reserved = data["reserved"] as? Bool ?? false
                let player = data["player"] as? String ?? ""
                
                
                return Reservation(id: id, day: day, month: month, year: year, start: start, end: end, date: date, reserved: reserved, player: player)
            }
        }
    }
    
    //updates reservation with player, player's email, and sets the boolean value "reserved" to true
    //add courtNum for scaling

    func makeReservations(id: String, player: String, email: String){
        
        
        database.collection("reservations").document(id).updateData(["reserved":true, "player": player, "email": email]) {error in
            if let error = error{
                print("Error updating document :\(error)") //handle db writing error
            }
            else{
                print("updated document") //successful write to db
            }
        }
        
        
    }
    
}




