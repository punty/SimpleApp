//
//  PostsRouter.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 11/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation

final class PostsRouter: NavigationRouter<PostViewModel> {
    override func route(route: PostViewModel.Routes) {
        switch route {
        case .showDetails(let post):
            let dependencies = DetailsViewModel.Dependencies(post: post, detailsFlow: DetailsFlow(serviceClient: Application.serviceClient, persistenceService: Application.persistenceService))
            let router = DetailsRouter()
            router.context = self.context
            let viewModel: Attachable<DetailsViewModel> = .detached(dependencies, router: router)
            let detailsViewController = DetailsViewController(viewModel: viewModel)
            self.context?.pushViewController(detailsViewController, animated: true)
        }
    }
}
