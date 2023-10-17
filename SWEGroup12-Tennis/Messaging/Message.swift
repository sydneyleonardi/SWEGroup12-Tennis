//
//  Message.swift
//  SWEGroup12-Tennis
//
//  Created by Kathleen Katchis on 10/16/23.
//

import Foundation

struct Message: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var message: String
}
