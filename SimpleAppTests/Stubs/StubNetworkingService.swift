//
//  StubNetworkingService.swift
//  SimpleAppTests
//
//  Created by Francesco Puntillo on 12/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
import RxTest
import RxSwift

@testable import SimpleApp

final class StubNetworkingService: ServiceClientType {

    enum StubError: Error {
        case testError
    }

    let testScheduler: SimpleTestScheduler
    let fails: Bool

    init(testScheduler: SimpleTestScheduler, fails: Bool = false) {
        self.testScheduler = testScheduler
        self.fails = fails
    }

    func get<T>(api: API) -> Observable<T> where T: Decodable, T: Encodable {
        if fails {
            let testObservable: TestableObservable<T> = testScheduler.scheduler.createColdObservable([error(1, StubError.testError)])
            return testObservable.asObservable()
        }
        let stubData = api.stubResponse()
        // swiftlint:disable force_try
        let objects = try! JSONDecoder().decode(T.self, from: stubData)
        // swiftlint:enable force_try
        let testObservable = testScheduler.scheduler.createColdObservable(
            [ next( testScheduler.next(), objects),
              completed(testScheduler.next())])
        return testObservable.asObservable()
    }
}
