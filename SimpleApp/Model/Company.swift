//
//  Company.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 12/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation

struct Company: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case catchPhrase
        case companyBs = "bs"
    }
    let name: String
    let catchPhrase: String
    let companyBs: String
}
