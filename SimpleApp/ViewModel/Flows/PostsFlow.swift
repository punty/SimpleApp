//
//  PostsFlow.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 09/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
import RxSwift

protocol PostFlowProtocol {
    func updatePost() -> Observable<[Post]>
    func storedPosts() -> Observable<[Post]>
}

final class PostsFlow: PostFlowProtocol {

    private let serviceClient: ServiceClientProtocol
    private let persistenceService: PersistenceServiceProtocol

    init (serviceClient: ServiceClientProtocol, persistenceService: PersistenceServiceProtocol) {
        self.serviceClient = serviceClient
        self.persistenceService = persistenceService
    }

    private func fetchPosts() -> Observable<[Post]> {
        return serviceClient.get(api: PostsAPI.posts)
    }
    
    func updatePost() -> Observable<[Post]> {
        return fetchPosts().catchError { error -> Observable<[Post]> in
            return self.storedPosts()
        }
    }

    func storedPosts() -> Observable<[Post]> {
        return persistenceService.fetch(predicate: nil, sortDescriptors: [])
            .map { (fetchedPost: FetchedResults<Post>) -> [Post] in
            return Array(fetchedPost)
        }
    }
}
