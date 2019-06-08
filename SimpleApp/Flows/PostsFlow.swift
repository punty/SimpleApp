//
//  PostsFlow.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 09/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
import RxSwift

protocol PostFlowType {
    func updatePost() -> Observable<[Post]>
    func storedPosts() -> Observable<[Post]>
}

final class PostsFlow: PostFlowType {

    private let serviceClient: ServiceClientType
    private let persistenceService: PersistenceServiceType

    init (serviceClient: ServiceClientType, persistenceService: PersistenceServiceType) {
        self.serviceClient = serviceClient
        self.persistenceService = persistenceService
    }

    func updatePost() -> Observable<[Post]> {
        return Observable.create { obs in
            let dataTask = self.serviceClient.get(api: API.posts) { (result: Result<[Post], ServiceError>) in
                switch result {
                case .success (let posts):
                    obs.on(.next(posts))
                    obs.onCompleted()
                case .failure (let error):
                    obs.onError(error)
                }
            }
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }

    func storedPosts() -> Observable<[Post]> {
        return persistenceService.fetch(predicate: nil, sortDescriptors: [])
            .map { (fetchedPost: FetchedResults<Post>) -> [Post] in
            return Array(fetchedPost)
        }
    }
}
