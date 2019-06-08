//
//  StubAPI.swift
//  SimpleAppTests
//
//  Created by Francesco Puntillo on 12/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
@testable import SimpleApp

extension API {
    func stubResponse() -> Data {
        let bundle = Bundle(for: PostViewModelTests.self)
        switch self {
        case .comments:
            let fileUrl = bundle.url(forResource: "comments", withExtension: "json")!
            let data = try! Data(contentsOf: fileUrl)
            return data
        case .posts:
            let fileUrl = bundle.url(forResource: "posts", withExtension: "json")!
            let data = try! Data(contentsOf: fileUrl)
            return data
        case .users:
            let fileUrl = bundle.url(forResource: "users", withExtension: "json")!
            let data = try! Data(contentsOf: fileUrl)
            return data
        }
    }
}
