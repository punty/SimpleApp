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
    var count: Int = 0
    func cancel() {
        count += 1
    }
}

final class StubNetworkingService: ServiceClientProtocol {
    enum StubError: Error {
        case testError
    }

    let fails: Bool
    
    var dataTaskSpy: DataSpy

    init(fails: Bool = false, dataTaskSpy: DataSpy) {
        self.fails = fails
        self.dataTaskSpy = dataTaskSpy
    }
    
    func get<T>(api: API, completion: @escaping (Result<T, ServiceError>) -> Void) -> DataTask where T : Decodable, T : Encodable {
        if fails {
            completion(.failure(.networkError))
            return dataTaskSpy
        }
        let stubData = api.stubResponse()
        let objects = try! JSONDecoder().decode(T.self, from: stubData)
        completion(.success(objects))
        return dataTaskSpy
    }
}
