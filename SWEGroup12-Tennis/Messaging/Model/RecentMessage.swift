//
//  RecentMessage.swift
//  SWEGroup12-Tennis
//
//  Created by Jhanavi Thakkar on 11/11/23.
//

import Foundation
import Firebase

struct RecentMessage: Identifiable {
    
    var id: String { documentId }
    
    let documentId: String
    let text, email, name: String
    let fromId, toId: String
    let profileImageURL: String
    let timestamp: Date
    
    //fill in with firebase constants
    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.text = data["text"] as? String ?? ""
        self.fromId = data["fromId"] as? String ?? ""
        self.toId = data["toId"] as? String ?? ""
        self.profileImageURL = data["profileImageURL"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        if let timestamp = data["timestamp"] as? Timestamp {
        self.timestamp = timestamp.dateValue()
    } else {
        self.timestamp = Date()
    }
    }
    
    var timeAgo: String{
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
}
