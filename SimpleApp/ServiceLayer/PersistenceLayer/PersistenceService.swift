//
//  PersistenceService.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 09/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
import RxSwift

protocol PersistenceServiceType {
    func store<T: Persistable>(items: [T], update: Bool) -> Observable<[T]>
    func fetch<T: Persistable>(predicate: NSPredicate?,
                               sortDescriptors: [NSSortDescriptor]) -> Observable<FetchedResults<T>>
}
