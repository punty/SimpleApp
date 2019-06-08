//
//  User.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 08/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation

struct User: Codable {
    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case name
        case username
        case email
        case address
        case phone
        case website
        case company
    }
    let userId: Int
    let name: String
    let username: String
    let email: String
    var address: Address?
    let phone: String
    let website: String
    var company: Company?
}
