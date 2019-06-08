//
//  Router.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 08/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import UIKit

// MARK: - Routable
protocol RoutableType: class {
    associatedtype Routes
}

// MARK: - Routable
protocol Router {
    associatedtype Context: AnyObject
    associatedtype Routable: RoutableType
    var context: Context? {get set}
    func route(route: Routable.Routes)
}

// MARK: - Routable
class NavigationRouter<R: RoutableType>: Router {
    weak var context: UINavigationController?
    typealias Routable = R
    func route(route: Routable.Routes) {
        fatalError("Base Router has nothing to do")
    }
}
