//
//  Comment.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 08/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation

struct Comment: Codable {
    enum CodingKeys: String, CodingKey {
        case postId
        case commentId = "id"
        case name
        case email
        case body
    }

    let postId: Int
    let commentId: Int
    let name: String
    let email: String
    let body: String
}
