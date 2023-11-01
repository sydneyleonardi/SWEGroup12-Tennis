//
//  Match.swift
//  SWEGroup12-Tennis
//
//  Created by Kathleen Katchis on 10/15/23.
//

import Foundation
//structure to hold match personal data
//need to add more for timing preferences
struct Match: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var skillLevel: String
    var email: String
    var gender: String
    var type: String
}
