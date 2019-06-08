//
//  PostTableViewCell.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 11/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    static var name: String = "PostTableViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    func configure(viewModel: PostCellViewModel) {
        titleLabel.text = viewModel.title
        bodyLabel.text = viewModel.body
    }

}
