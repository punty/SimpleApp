//
//  StubStorageService.swift
//  SimpleAppTests
//
//  Created by Francesco Puntillo on 12/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
import RxTest
import RxSwift

@testable import SimpleApp

extension Array: ResultBox {
    public func count() -> Int {
        return self.count
    }
    public func value(at index: Int) -> Any {
        return self[index]
    }
}

final class StubStorageService<T: Persistable>: PersistenceServiceType {

    let items: [T]
    let testScheduler: SimpleTestScheduler

    init (items: [T], testScheduler: SimpleTestScheduler) {
        self.testScheduler = testScheduler
        self.items = items
    }

    func fetch<T>(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]) -> Observable<FetchedResults<T>> where T: Persistable {
        let fetchedResult: FetchedResults<T> = FetchedResults(results: items.map {$0.managedObject()})
        return testScheduler.scheduler.createColdObservable(
            [next( testScheduler.next(), fetchedResult),
             completed(testScheduler.next())]
        ).asObservable()
    }

    func store<T>(items: [T], update: Bool) -> Observable<[T]> where T: Persistable {
        return testScheduler.scheduler.createColdObservable(
            [next( testScheduler.next(), items),
             completed(testScheduler.next())]
        ).asObservable()
    }
}

final class StubEmptyStorage: PersistenceServiceType {

    let testScheduler: SimpleTestScheduler

    init (testScheduler: SimpleTestScheduler) {
        self.testScheduler = testScheduler
    }

    func fetch<T>(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]) -> Observable<FetchedResults<T>> where T: Persistable {
        let emptyArray: [T] = []
        let fetchedResult: FetchedResults<T> = FetchedResults(results: emptyArray)
        return testScheduler.scheduler.createColdObservable(
            [next( testScheduler.next(), fetchedResult),
             completed(testScheduler.next())]
        ).asObservable()
    }

    func store<T>(items: [T], update: Bool) -> Observable<[T]> where T: Persistable {
        let emptyArray: [T] = []
        return testScheduler.scheduler.createColdObservable(
            [next( testScheduler.next(), emptyArray),
             completed(testScheduler.next())]
        ).asObservable()
    }
}
