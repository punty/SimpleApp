//
//  RealmPersistenceLayer.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 09/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

final class RealmPersistence {

    static func add<T>(_ values: [T], _ type: T.Type) where T: Persistable {
        // swiftlint:disable force_try
        let realm = try! Realm()
        try! realm.write {
            // swiftlint:enable force_try
            for case let element as Object in values.map({$0.managedObject()}) {
                 realm.add(element, update: .all)
            }
        }
    }

    static func fetch<T: Persistable> (_ type: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [SortDescriptor] = []) -> FetchedResults<T> {

        guard let type = T.ManagedObject.self as? Object.Type else {
            fatalError("to store object in Realm the ManagedObject type should be an 'Object'")
        }
        // swiftlint:disable force_try
        let realm = try! Realm()
        // swiftlint:enable force_try
        var results = realm.objects(type)
        if let predicate = predicate {
            results = results.filter(predicate)
        }
        results = results.sorted(by: sortDescriptors)
        return FetchedResults(results: results)

    }
}

extension RealmPersistence: PersistenceServiceType {
    func fetch<T: Persistable>(predicate: NSPredicate?,
                               sortDescriptors: [NSSortDescriptor]) -> Observable<FetchedResults<T>> {
                let realmSortDescriptor = sortDescriptors.compactMap { descriptor -> SortDescriptor? in
                guard let key = descriptor.key else {
                    return nil
                }
                return SortDescriptor(keyPath: key, ascending: descriptor.ascending)
            }
            return Observable.create { observer in
                let result = RealmPersistence.fetch(T.self, predicate: predicate, sortDescriptors: realmSortDescriptor)
                observer.onNext(result)
                observer.onCompleted()
                return Disposables.create()
            }
    }

    func store<T: Persistable>(items: [T], update: Bool = true) -> Observable<[T]> {
        return Observable.create { observer in
            RealmPersistence.add(items, T.self)
            observer.onNext(items)
            observer.onCompleted()
            return Disposables.create()
        }
    }

}
