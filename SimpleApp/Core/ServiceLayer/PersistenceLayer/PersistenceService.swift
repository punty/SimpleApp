//
//  PersistenceService.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 09/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation

enum PersistenceError: Error {
    case storageError
}

protocol PersistenceServiceProtocol {
    func store<T: Persistable>(items: [T], completion: @escaping (Result<[T], PersistenceError>) -> Void)
    func fetch<T: Persistable>(predicate: NSPredicate?,
                               sortDescriptors: [NSSortDescriptor], completion: @escaping (FetchedResults<T>) -> Void)
}
