//
//  API.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 08/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation

enum API: String {

    static let baseURLString = "http://jsonplaceholder.typicode.com/"

    case posts
    case users
    case comments

    func asURLRequest() -> URLRequest {
        let path = API.baseURLString + self.rawValue
        let url = URL(string: path)
        guard let urlUnwrap = url else {fatalError()}
        let request = URLRequest(url: urlUnwrap)
        return request
    }
}
