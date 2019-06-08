//
//  DetailsFlow.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 11/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
import RxSwift

final class DetailsFlow {

    private let serviceClient: ServiceClientType
    private let persistenceService: PersistenceServiceType

    init (serviceClient: ServiceClientType, persistenceService: PersistenceServiceType) {
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
        return Observable.create { obs in
            let dataTask = self.serviceClient.get(api: API.comments) { (result: Result<[Comment], ServiceError>) in
                switch result {
                case .success(let comments):
                    obs.on(.next(comments))
                    obs.onCompleted()
                case .failure(let error):
                    obs.on(.error(error))
                }
            }
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }

    private func numberOfComments(for postId: Int) -> Observable<Int> {
        return comments(for: postId)
            .flatMap {(comments: [Comment]) in
                return self.persistenceService.store(items: comments, update: true)
            }.map { comments in
                return comments.filter {$0.postId == postId}.count
        }
    }
    
    private func users() -> Observable<[User]> {
        return Observable.create { obs in
            let dataTask = self.serviceClient.get(api: API.users) { (result: Result<[User], ServiceError>) in
                switch result {
                case .success(let comments):
                    obs.on(.next(comments))
                    obs.onCompleted()
                case .failure(let error):
                    obs.on(.error(error))
                }
            }
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }

    private func user(for userId: Int) -> Observable<User?> {
        return users()
            .flatMap { (users: [User]) in
                return self.persistenceService.store(items: users, update: true)
            }.map { users in
                return users.filter {$0.userId == userId}.first
        }
    }
}
