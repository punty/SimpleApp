//
//  Persistable.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 09/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation

protocol Persistable {
    associatedtype ManagedObject
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}
