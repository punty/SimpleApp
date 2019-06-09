//
//  RealmPersistenceLayer.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 09/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmPersistence {

    static func add<T>(_ values: [T], _ type: T.Type) -> Result<Void, Error> where T: Persistable {
        let realm = try! Realm()
        return Result {
           try realm.write {
                for case let element as Object in values.map({$0.managedObject()}) {
                     realm.add(element, update: .all)
                }
            }
        }
    }

    static func fetch<T: Persistable> (_ type: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [SortDescriptor] = []) -> FetchedResults<T> {

        guard let type = T.ManagedObject.self as? Object.Type else {
            fatalError("to store object in Realm the ManagedObject type should be an 'Object'")
        }
        let realm = try! Realm()
        var results = realm.objects(type)
        if let predicate = predicate {
            results = results.filter(predicate)
        }
        results = results.sorted(by: sortDescriptors)
        return FetchedResults(results: results)
    }
}

extension RealmPersistence: PersistenceServiceProtocol {
    func store<T>(items: [T], completion: @escaping (Result<[T], PersistenceError>) -> Void) where T : Persistable {
        let result = RealmPersistence.add(items, T.self).mapError { _ in return PersistenceError.storageError }.map {
            return items
        }
        completion(result)
    }
    
    func fetch<T>(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor], completion: @escaping (FetchedResults<T>) -> Void) where T : Persistable {
        let realmSortDescriptor = sortDescriptors.compactMap { descriptor -> SortDescriptor? in
            guard let key = descriptor.key else {
                return nil
            }
            return SortDescriptor(keyPath: key, ascending: descriptor.ascending)
        }
        
        let result = RealmPersistence.fetch(T.self, predicate: predicate, sortDescriptors: realmSortDescriptor)
        completion(result)
    }
}
