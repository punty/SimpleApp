//
//  ApplicationServices.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 09/06/2019.
//  Copyright © 2019 FP. All rights reserved.
//

import Foundation

struct ApplicationServices {
    // MARK: - Services
    let serviceClient: ServiceClientProtocol = ServiceClient()
    let persistenceService: PersistenceServiceProtocol = RealmPersistence()
}
