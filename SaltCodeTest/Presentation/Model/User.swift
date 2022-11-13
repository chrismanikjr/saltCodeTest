//
//  User.swift
//  SaltCodeTest
//
//  Created by Chrismanto Natanail Manik on 13/11/22.
//

import Foundation

struct UserResponse: Codable{
    var data: [User]
}
struct User: Codable{
    let id: Int
    let email: String
    var first_name: String
    var last_name: String
    var avatar: String
    var name: String{
        return "\(first_name) \(last_name)"
    }
}
