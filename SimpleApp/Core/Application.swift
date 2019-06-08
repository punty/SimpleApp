//
//  Application.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 07/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import UIKit
import RxSwift

final class Application {
    lazy var rootViewController: UINavigationController = {
        let navigationController = UINavigationController()
        let postFlow = PostsFlow(serviceClient: Application.serviceClient, persistenceService: Application.persistenceService)
        let router = PostsRouter()
        router.context = navigationController
        let viewModel: Attachable<PostViewModel> = .detached(PostViewModel.Dependencies(postsFlow: postFlow), router: router)
        let postViewController = PostsViewController(viewModel: viewModel)
        navigationController.viewControllers = [postViewController]
        return navigationController
    }()

    // MARK: - Services
    static let serviceClient: ServiceClientType = ServiceClient()
    static let persistenceService: PersistenceServiceType = RealmPersistence()
}
