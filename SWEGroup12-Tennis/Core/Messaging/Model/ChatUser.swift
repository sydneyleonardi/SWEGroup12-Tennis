//
//  ChatUser.swift
//  SWEGroup12-Tennis
//
//  Created by Jhanavi Thakkar on 11/11/23.
//

import Foundation

struct ChatUser: Identifiable {
    
    var id: String { uid }
    
    let uid: String
    let name: String
    let gender: String
    let age: String
    let skillLevel: String
    let playType: String
    let email: String
    let description: String
    let datesSelected: Array<Int>
    let profileImageURL: String

    init(data: [String: Any]) {
        self.uid = data["id"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.gender = data["gender"] as? String ?? ""
        self.age = data["age"] as? String ?? ""
        self.skillLevel = data["skillLevel"] as? String ?? ""
        self.playType = data["type"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.description = data["description"] as? String ?? ""
        self.datesSelected = data["datesSelected"] as? Array<Int> ?? []
        self.profileImageURL = data["profileImageURL"] as? String ?? "person.fill"
    }
}

