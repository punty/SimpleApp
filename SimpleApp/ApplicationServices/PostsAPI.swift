//
//  PostsAPI.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 08/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation

enum PostsAPI: String, API {
    
    static let baseURLString = "http://jsonplaceholder.typicode.com/"

    case posts
    case users
    case comments
    
    func path() -> String {
        return rawValue
    }

    func asURLRequest() -> URLRequest {
        let urlString = PostsAPI.baseURLString + path()
        let url = URL(string: urlString)
        guard let urlUnwrap = url else {fatalError()}
        let request = URLRequest(url: urlUnwrap)
        return request
    }
}
