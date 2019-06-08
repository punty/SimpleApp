//
//  PostsViewController.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 10/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class PostsViewController: UIViewController {

    @IBOutlet private weak var postsTableView: UITableView!

    private var disposeBag = DisposeBag()

    private var viewModel: PostViewModel

    init (viewModel: PostViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    private func registerCell() {
        postsTableView.register(UINib.init(nibName: PostTableViewCell.name, bundle: nil), forCellReuseIdentifier: PostTableViewCell.name)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        registerCell()
        postsTableView.rx.modelSelected(PostCellViewModel.self)
            .subscribe(onNext: { cellViewModel in
                self.viewModel.modelSelected(cell: cellViewModel.post)
        }).disposed(by: disposeBag)
        
        viewModel.items.drive(postsTableView.rx.items(cellIdentifier: PostTableViewCell.name, cellType: PostTableViewCell.self)) { _, viewModel, cell in
            cell.configure(viewModel: viewModel)
        }
        .disposed(by: disposeBag)
    }
}
