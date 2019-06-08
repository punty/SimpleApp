//
//  PostsViewModel.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 11/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class PostViewModel: ViewModel, RoutableType {
    typealias Router = PostsRouter

    private var disposeBag = DisposeBag()

    enum Routes {
        case showDetails (post: Post)
    }

    var dependencies: Dependencies
    struct Dependencies {
        let postsFlow: PostFlowType
    }

    struct Bindings {
        let modelSelected: Driver<PostCellViewModel>
    }

    var router: PostsRouter?

    // MARK: - Output
    let items: Driver<[PostCellViewModel]>

    init(dependencies: Dependencies, bindings: Bindings, router: Router?) {
        self.router = router
        self.dependencies = dependencies

        let update = dependencies.postsFlow.updatePost().share()

        items = update.map { posts in
            return posts.map {PostCellViewModel(post: $0)}
        }
        .asDriver(onErrorJustReturn: [])
        .startWith([])

        bindings.modelSelected.drive(onNext: { [unowned self] cellViewModel in
            self.router?.route(route: .showDetails(post: cellViewModel.post))
        }).disposed(by: disposeBag)
    }
}
