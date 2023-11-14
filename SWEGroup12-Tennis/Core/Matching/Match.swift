//
//  Match.swift
//  SWEGroup12-Tennis
//
//  Created by Sydney Leonardi on 11/14/23.
//

import Foundation

// Structure to hold match personal data
// Need to add more for timing preferences
struct Match: Identifiable, Equatable {
    var id: String = UUID().uuidString
    var userID: String
    var name: String
    var skillLevel: String
    var gender: String
    var type: String
    var time: [Int]

    static func == (lhs: Match, rhs: Match) -> Bool {
        // Customize this logic based on how you want to compare matches
        return lhs.userID == rhs.userID &&
            lhs.name == rhs.name &&
            lhs.skillLevel == rhs.skillLevel &&
            lhs.gender == rhs.gender &&
            lhs.type == rhs.type &&
            lhs.time == rhs.time
    }
}
