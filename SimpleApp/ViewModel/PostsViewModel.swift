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

final class PostViewModel {
  
    private var disposeBag = DisposeBag()

    enum Routes {
        case showDetails (post: Post)
    }

    var dependencies: Dependencies
    weak var flowDelegate: PostsFlowControllerDelegate?
    struct Dependencies {
        let postsFlow: PostFlowProtocol
    }
    
    // MARK: - Output
    let items: Driver<[PostCellViewModel]>

    init(dependencies: Dependencies, flowDelegate: PostsFlowControllerDelegate) {
        self.dependencies = dependencies
        self.flowDelegate = flowDelegate
        let update = dependencies.postsFlow.updatePost().share()

        items = update.map { posts in
            return posts.map {PostCellViewModel(post: $0)}
        }
        .asDriver(onErrorJustReturn: [])
        .startWith([])
    }
    
    func modelSelected(model: Post) {
        flowDelegate?.showDetails(post: model)
    }
}
