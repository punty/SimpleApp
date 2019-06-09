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

final class StubStorageService<T: Persistable>: PersistenceServiceProtocol {
    
    func fetch<T>(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor], completion: @escaping (FetchedResults<T>) -> Void) where T : Persistable {
        let fetchedResult: FetchedResults<T> = FetchedResults(results: items.map {$0.managedObject()})
        completion(fetchedResult)
    }
    
    func store<T>(items: [T], completion: @escaping (Result<[T], PersistenceError>) -> Void) where T : Persistable {
        completion(.success(items))
    }
    let items: [T]

    init (items: [T]) {
        self.items = items
    }
}

