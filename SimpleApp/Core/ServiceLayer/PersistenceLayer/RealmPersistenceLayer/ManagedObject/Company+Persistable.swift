//
//  Company+Persistable.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 12/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
import RealmSwift

final class CompanyObject: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var catchPhrase: String = ""
    @objc dynamic var companyBs: String = ""

    override public static func primaryKey() -> String? {
        return "name"
    }
}

extension Company: Persistable {
    typealias ManagedObject = CompanyObject

    init(managedObject: CompanyObject) {
        self.name = managedObject.name
        self.catchPhrase = managedObject.catchPhrase
        self.companyBs = managedObject.companyBs
    }

    func managedObject() -> CompanyObject {
        let company = CompanyObject()
        company.name = name
        company.catchPhrase = catchPhrase
        company.companyBs = companyBs
        return company
    }
}
