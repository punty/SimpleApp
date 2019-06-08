//
//  ViewModel.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 08/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation

// MARK: - ViewModel
protocol ViewModel {
    associatedtype Dependencies
    associatedtype Bindings
    associatedtype RouterType: Router

    var dependencies: Dependencies {get set}
    var router: RouterType? {get set}

    init(dependencies: Dependencies, bindings: Bindings, router: RouterType?)
}

// MARK: - Attachable
enum Attachable<VM: ViewModel> {

    case detached(VM.Dependencies, router: VM.RouterType)
    case attached(VM)

    mutating func bind(_ bindings: VM.Bindings) -> VM {
        switch self {
        case .attached(let viewModel):
            return viewModel
        case .detached(let dependencies, let router):
            let vm = VM.init(dependencies: dependencies, bindings: bindings, router: router)
            self = .attached(vm)
            return vm
        }
    }
}
