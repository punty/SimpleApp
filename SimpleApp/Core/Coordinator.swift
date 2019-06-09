//
//  Coordinator.swift
//  Videodrome
//
//  Created by Francesco Puntillo on 14/04/2019.
//  Copyright © 2019 Francesco Puntillo. All rights reserved.
//

import UIKit

public protocol Coordinator: class {
    var name: String { get }
    var sceneRoot: UINavigationController { get }
    func start()
}

public extension Coordinator {
    var name: String {
        return String(describing: self)
    }
}
