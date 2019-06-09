//
//  StubNetworkingService.swift
//  SimpleAppTests
//
//  Created by Francesco Puntillo on 12/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
@testable import SimpleApp

final class DataSpy: DataTask {
    func cancel() {
        //no op
    }
}

final class StubNetworkingService: ServiceClientType {

    enum StubError: Error {
        case testError
    }

    let fails: Bool

    init(fails: Bool = false) {
        self.fails = fails
    }
    
    func get<T>(api: API, completion: @escaping (Result<T, ServiceError>) -> Void) -> DataTask where T : Decodable, T : Encodable {
        if fails {
            completion(.failure(.networkError))
            return DataSpy()
        }
        let stubData = api.stubResponse()
        let objects = try! JSONDecoder().decode(T.self, from: stubData)
        completion(.success(objects))
        return DataSpy()
    }
}
