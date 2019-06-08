//
//  Post+Persistable.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 09/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
import RealmSwift

final class PostObject: Object {
    @objc dynamic var userId: Int = 0
    @objc dynamic var postId: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""

    override public static func primaryKey() -> String? {
        return "postId"
    }
}

extension Post: Persistable {
    typealias ManagedObject = PostObject

    init(managedObject: PostObject) {
        postId = managedObject.postId
        userId = managedObject.userId
        title = managedObject.title
        body = managedObject.body
    }

    func managedObject() -> PostObject {
        let post = PostObject()
        post.postId = postId
        post.userId = userId
        post.title = title
        post.body = body
        return post
    }
}
