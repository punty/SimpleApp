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

    var viewModel: Attachable<DetailsViewModel>

    init(viewModel: Attachable<DetailsViewModel>) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        let bindedViewModel = self.viewModel.bind(DetailsViewModel.Bindings())
        bindedViewModel.body.drive(postTextView.rx.text).disposed(by: disposeBag)
        bindedViewModel.title.drive(titleLabel.rx.text).disposed(by: disposeBag)
        bindedViewModel.user.drive(userLabel.rx.text).disposed(by: disposeBag)
        bindedViewModel.commentCounter.drive(commentsLabel.rx.text).disposed(by: disposeBag)
        bindedViewModel.detailsTextColor.drive(onNext: {[unowned self] color in
            self.commentsLabel.textColor = color
            self.userLabel.textColor = color
        }).disposed(by: disposeBag)
    }
}
