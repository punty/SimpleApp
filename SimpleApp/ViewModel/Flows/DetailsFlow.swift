//
//  DetailsFlow.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 11/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
import RxSwift


protocol DetailsFlowProtocol {
    func updateDetails(for post: Post) -> Observable<Details>
    func storedUser(for userId: Int) -> Observable<User?>
    func storedCommentCount(for postId: Int) -> Observable<Int>
}

final class DetailsFlow: DetailsFlowProtocol {

    private let serviceClient: ServiceClientType
    private let persistenceService: PersistenceServiceProtocol

    init (serviceClient: ServiceClientType, persistenceService: PersistenceServiceProtocol) {
        self.serviceClient = serviceClient
        self.persistenceService = persistenceService
    }

    func storedCommentCount(for postId: Int) -> Observable<Int> {
        return persistenceService.fetch(predicate: NSPredicate(format: "postId == %d", postId), sortDescriptors: [])
            .map { (userResult: FetchedResults<Comment>) in
                return userResult.count
        }
    }

    func storedUser(for userId: Int) -> Observable<User?> {
        return persistenceService.fetch(predicate: NSPredicate(format: "userId == %d", userId), sortDescriptors: []).map { (userResult: FetchedResults<User>) in
            return userResult.first
        }
    }

    func updateDetails(for post: Post) -> Observable<Details> {
        let comments = numberOfComments(for: post.postId)
        let userInfo = user(for: post.userId)
        return Observable.zip(comments, userInfo) { comment, user in
            return Details(user: user, numberOfComments: comment)
        }
    }
    
    private func comments(for postId: Int) -> Observable<[Comment]> {
        return serviceClient.get(api: PostsAPI.comments)
    }

    private func numberOfComments(for postId: Int) -> Observable<Int> {
        return comments(for: postId)
            .flatMap {(comments: [Comment]) in
                return self.persistenceService.store(items: comments)
            }.map { comments in
                return comments.filter {$0.postId == postId}.count
        }
    }
    
    private func users() -> Observable<[User]> {
        return serviceClient.get(api: PostsAPI.users)
    }

    private func user(for userId: Int) -> Observable<User?> {
        return users()
            .flatMap { (users: [User]) in
                return self.persistenceService.store(items: users)
            }.map { users in
                return users.filter {$0.userId == userId}.first
        }
    }
}
