//
//  DetailsViewController.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 10/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsViewController: UIViewController {

    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    private var disposeBag = DisposeBag()

    var viewModel: DetailsViewModel

    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        viewModel.body.drive(postTextView.rx.text).disposed(by: disposeBag)
        viewModel.title.drive(titleLabel.rx.text).disposed(by: disposeBag)
        viewModel.user.drive(userLabel.rx.text).disposed(by: disposeBag)
        viewModel.commentCounter.drive(commentsLabel.rx.text).disposed(by: disposeBag)
        viewModel.detailsTextColor.drive(onNext: {[unowned self] color in
            self.commentsLabel.textColor = color
            self.userLabel.textColor = color
        }).disposed(by: disposeBag)
    }
}
