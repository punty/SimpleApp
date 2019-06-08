//
//  Comment+Persistable.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 09/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
import RealmSwift

final class CommentObject: Object {
    @objc dynamic var postId: Int = 0
    @objc dynamic var commentId: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var body: String = ""

    override public static func primaryKey() -> String? {
        return "commentId"
    }
}

extension Comment: Persistable {
    typealias ManagedObject = CommentObject

    init(managedObject: CommentObject) {
        postId = managedObject.postId
        commentId = managedObject.commentId
        name = managedObject.name
        email = managedObject.email
        body = managedObject.body
    }

    func managedObject() -> CommentObject {
        let comment = CommentObject()
        comment.postId = postId
        comment.commentId = commentId
        comment.name = name
        comment.email = email
        comment.body = body
        return comment
    }
}
