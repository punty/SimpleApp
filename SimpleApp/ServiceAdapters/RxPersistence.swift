//
//  RxPersistence.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 09/06/2019.
//  Copyright © 2019 FP. All rights reserved.
//

import Foundation
import RxSwift

extension PersistenceServiceProtocol {
    func fetch<T: Persistable>(predicate: NSPredicate?,
                               sortDescriptors: [NSSortDescriptor]) -> Observable<FetchedResults<T>> {
        return Observable.create { observer in
            self.fetch(predicate: predicate, sortDescriptors: sortDescriptors) { (result: FetchedResults<T>) in
                observer.onNext(result)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func store<T: Persistable>(items: [T]) -> Observable<[T]> {
        return Observable.create { observer in
            self.store(items: items) { results in
                switch results {
                case .success(let items):
                    observer.onNext(items)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
