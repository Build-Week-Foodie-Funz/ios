//
//  User.swift
//  FoodieFun
//
//  Created by Steven Leyva on 9/24/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import Foundation
struct  User: Codable, Equatable {
    let userID: Int?
    let username: String
    let password: String
    let email: String?
    let token: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "userid"
        case username
        case password
        case email
        case token
    }
}

struct UserLogin: Codable, Equatable{
    let username: String
    let password: String
    
}

