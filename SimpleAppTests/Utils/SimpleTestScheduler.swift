//
//  SimpleTestScheduler.swift
//  SimpleAppTests
//
//  Created by Francesco Puntillo on 12/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
import RxTest

final class SimpleTestScheduler {
    let scheduler: TestScheduler = TestScheduler(initialClock: 0, resolution: 1.0, simulateProcessingDelay: false)
    var time: TestTime = 0

    func next() -> TestTime {
        let currenTime = time
        time += 1
        return currenTime
    }
}
