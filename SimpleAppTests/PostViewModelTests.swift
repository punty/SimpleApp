//
//  PostViewModelTests.swift
//  SimpleAppTests
//
//  Created by Francesco Puntillo on 12/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxCocoa

@testable import SimpleApp

final class PostViewModelTests: XCTestCase {

    var testScheduler: SimpleTestScheduler!
    var disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        self.testScheduler = SimpleTestScheduler()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testItems() {
        let serviceClient = StubNetworkingService(testScheduler: testScheduler)
        let post = Post(userId: 0, postId: 0, title: "title", body: "body")
        let persistence = StubStorageService(items: [post], testScheduler: testScheduler)
        let postFlow = PostsFlow(serviceClient: serviceClient, persistenceService: persistence)
        let itemSelect: Driver<PostCellViewModel> = Driver.empty()
        let dependencies = PostViewModel.Dependencies(postsFlow: postFlow)
        let bindings = PostViewModel.Bindings(modelSelected: itemSelect)
        let postViewModel = PostViewModel(dependencies: dependencies, bindings: bindings, router: nil)
        SharingScheduler.mock(scheduler: testScheduler.scheduler) {
            let observer = testScheduler.scheduler.createObserver([PostCellViewModel].self)
            postViewModel.items.asObservable().subscribe(observer).disposed(by: disposeBag)
            testScheduler.scheduler.start()
            //first empty table view (from start with)
            XCTAssert(observer.events[0].time == 0)
            XCTAssert(observer.events[0].value.element?.count == 0)
            //then we have 4 items from the mock
            XCTAssert(observer.events[1].time == 2) //after 2 steps (get-store)
            XCTAssert(observer.events[1].value.element?.count == 4)
        }
    }

    //if online we fetch the post we have in our storage
    func testOfflineFromCache() {
        let serviceClient = StubNetworkingService(testScheduler: testScheduler, fails: true)
        let post = Post(userId: 0, postId: 0, title: "MockStorage", body: "Mock")
        let persistence = StubStorageService(items: [post], testScheduler: testScheduler)
        let postFlow = PostsFlow(serviceClient: serviceClient, persistenceService: persistence)
        let itemSelect: Driver<PostCellViewModel> = Driver.empty()
        let dependencies = PostViewModel.Dependencies(postsFlow: postFlow)
        let bindings = PostViewModel.Bindings(modelSelected: itemSelect)
        let postViewModel = PostViewModel(dependencies: dependencies, bindings: bindings, router: nil)
        SharingScheduler.mock(scheduler: testScheduler.scheduler) {
            let observer = testScheduler.scheduler.createObserver([PostCellViewModel].self)
            postViewModel.items.asObservable().subscribe(observer).disposed(by: disposeBag)
            testScheduler.scheduler.start()
            //first empty table view (from start with)
            XCTAssert(observer.events[0].time == 0)
            XCTAssert(observer.events[0].value.element?.count == 0)
            //then we have 1 items from the mock Storage
            XCTAssert(observer.events[1].time == 1) //after 1 step (fetch)
            XCTAssert(observer.events[1].value.element?[0].title == "MockStorage")
        }
    }

}
