//
//  Address+Persistable.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 11/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
import RealmSwift

final class AddressObject: Object {
    @objc dynamic var street: String = ""
    @objc dynamic var suite: String = ""
    @objc dynamic var city: String = ""
    @objc dynamic var zipcode: String = ""
    @objc dynamic var geo: GeoObject?
    @objc dynamic var compoundKey: String = ""

    override public static func primaryKey() -> String? {
        return "compoundKey"
    }
}

extension Address: Persistable {
    typealias ManagedObject = AddressObject

    init(managedObject: AddressObject) {
        self.street = managedObject.street
        self.suite = managedObject.suite
        self.city = managedObject.city
        self.zipcode = managedObject.zipcode
        if let geoLocation = managedObject.geo {
            self.geo = Geo(managedObject: geoLocation)
        } else {
            self.geo = nil
        }
    }

    func managedObject() -> AddressObject {
        let userAddress = AddressObject()
        userAddress.street = street
        userAddress.suite = suite
        userAddress.city = city
        userAddress.zipcode = zipcode
        userAddress.geo = geo?.managedObject()
        userAddress.compoundKey = "\(street)-\(city)"
        return userAddress
    }
}
