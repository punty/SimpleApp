//
//  User+Persistable.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 09/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
import RealmSwift

final class UserObject: Object {
    @objc dynamic var userId: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var address: AddressObject?
    @objc dynamic var phone: String = ""
    @objc dynamic var website: String = ""
    @objc dynamic var company: CompanyObject?

    override public static func primaryKey() -> String? {
        return "userId"
    }
}

extension User: Persistable {
    typealias ManagedObject = UserObject

    init(managedObject: UserObject) {
        userId = managedObject.userId
        name = managedObject.name
        username = managedObject.username
        email = managedObject.email
        if let addressObject = managedObject.address {
            address = Address(managedObject: addressObject)
        } else {
            address = nil
        }
        phone = managedObject.phone
        website = managedObject.website
        if let companyObject = managedObject.company {
            company = Company(managedObject: companyObject)
        } else {
            company = nil
        }
    }

    func managedObject() -> UserObject {
        let user = UserObject()
        user.userId = userId
        user.name = name
        user.username = username
        user.email = email
        user.address = address?.managedObject()
        user.phone = phone
        user.website = website
        user.company = company?.managedObject()
        return user
    }
}
