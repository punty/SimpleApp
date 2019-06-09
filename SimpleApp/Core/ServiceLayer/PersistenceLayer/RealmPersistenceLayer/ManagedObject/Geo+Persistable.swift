//
//  Geo+Persistable.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 11/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
import RealmSwift

final class GeoObject: Object {
    @objc dynamic var lat: String = ""
    @objc dynamic var lng: String = ""
    @objc dynamic var compoundKey: String = ""

    override public static func primaryKey() -> String? {
        return "compoundKey"
    }
}

extension Geo: Persistable {
    typealias ManagedObject = GeoObject
    init(managedObject: GeoObject) {
        self.lat = managedObject.lat
        self.lng = managedObject.lng
    }

    func managedObject() -> GeoObject {
        let geo = GeoObject()
        geo.lat = lat
        geo.lng = lng
        geo.compoundKey = "\(lat)-\(lng)"
        return geo
    }
}
