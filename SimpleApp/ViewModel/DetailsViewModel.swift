//
//  DetailsViewModel.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 11/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailsViewModel {

    private var disposeBag = DisposeBag()

    var dependencies: Dependencies

    struct Dependencies {
        let post: Post
        let detailsFlow: DetailsFlowProtocol
    }

   
    // MARK: - Output
    let title: Driver<String>
    let body: Driver<String>
    let user: Driver<String?>
    let commentCounter: Driver<String?>
    let detailsTextColor: Driver<UIColor>

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        title = Driver.just(dependencies.post.title)
        body = Driver.just(dependencies.post.body)
        let details = dependencies.detailsFlow.updateDetails(for: dependencies.post).share()

        user = details.map { details in
                return details.user?.name
            }.asDriver(onErrorRecover: { _ in
                return dependencies.detailsFlow.storedUser(for: dependencies.post.postId)
                    .map { user in
                        return user?.name
                }.asDriver(onErrorJustReturn: "")
            })
        .startWith("")

        commentCounter = details.map { detail in
                String(detail.numberOfComments)
            }.asDriver(onErrorRecover: { _ in
                return dependencies.detailsFlow.storedCommentCount(for: dependencies.post.postId)
                    .map { count in
                        return String(count)
                }.asDriver(onErrorJustReturn: "")
            })
        .startWith("")

        detailsTextColor = details.map { result in
            return .black
        }.asDriver(onErrorJustReturn: .red)
    }
}
