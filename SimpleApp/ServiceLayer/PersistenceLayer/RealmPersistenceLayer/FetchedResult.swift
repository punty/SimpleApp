//
//  FetchedResult.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 09/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
import RealmSwift

protocol ResultBox {
    func count() -> Int
    func value(at index: Int) -> Any
}

extension Results: ResultBox {
    func count() -> Int {
        return self.count
    }

    func value(at index: Int) -> Any {
        return self[index]
    }
}

final class FetchedResults<T: Persistable>:Collection {

    private let results: ResultBox

    var count: Int {
        return results.count()
    }
    init(results: ResultBox) {
        self.results = results
    }
    func value(at index: Int) -> T {
        let managedResult = results.value(at: index)
        guard let result = managedResult as? T.ManagedObject else {fatalError("Cannot get the Managed Object")}
        return T(managedObject: result)
    }
    var startIndex: Int {
        return 0
    }
    var endIndex: Int {
        return count
    }
    func index(after currentIndex: Int) -> Int {
        precondition(currentIndex < endIndex)
        return currentIndex + 1
    }
    subscript(position: Int) -> T {
        return value(at: position)
    }
}
