//
//  PostCoordinator.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 09/06/2019.
//  Copyright © 2019 FP. All rights reserved.
//

import UIKit

protocol PostsFlowControllerDelegate: class {
    func showDetails(post: Post)
}

final class AppCoordinator: Coordinator {
    
    let sceneRoot: UINavigationController
    let services: ApplicationServices
    
    func start() {
        let postFlow = PostsFlow(serviceClient: services.serviceClient, persistenceService: services.persistenceService)
        let dependencies = PostViewModel.Dependencies(postsFlow: postFlow)
        let viewModel = PostViewModel(dependencies: dependencies, flowDelegate: self)
        let postViewController = PostsViewController(viewModel: viewModel)
        sceneRoot.viewControllers = [postViewController]
    }
    
    init (sceneRoot: UINavigationController, services: ApplicationServices) {
        self.sceneRoot = sceneRoot
        self.services = services
    }
}

extension AppCoordinator: PostsFlowControllerDelegate {
    func showDetails(post: Post) {
        let detailsFlow = DetailsFlow(serviceClient: services.serviceClient, persistenceService: services.persistenceService)
        let dependencies = DetailsViewModel.Dependencies(post: post, detailsFlow: detailsFlow)
        let viewModel = DetailsViewModel(dependencies: dependencies)
        let detailsViewController = DetailsViewController(viewModel: viewModel)
        sceneRoot.pushViewController(detailsViewController, animated: true)
    }
}
