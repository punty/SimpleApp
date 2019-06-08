//
//  PostCellViewModel.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 11/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation

final class PostCellViewModel {
    let post: Post

    // MARK: - Output
    let title: String
    let body: String

    init (post: Post) {
        self.post = post
        self.title = post.title
        self.body = post.body
    }
}
