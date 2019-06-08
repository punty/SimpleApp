//
//  DetailsViewModelTest.swift
//  SimpleAppTests
//
//  Created by Francesco Puntillo on 12/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation

import XCTest
import RxSwift
import RxTest
import RxCocoa

@testable import SimpleApp

final class DetailsViewModelTests: XCTestCase {

    var testScheduler: SimpleTestScheduler!
    var disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        self.testScheduler = SimpleTestScheduler()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testOnlineBlackText() {
        let serviceClient = StubNetworkingService(testScheduler: testScheduler)
        let persistence = StubEmptyStorage(testScheduler: testScheduler)
        let detailsflow = DetailsFlow(serviceClient: serviceClient, persistenceService: persistence)
        let post = Post(userId: 0, postId: 0, title: "title", body: "body")
        let dependencies = DetailsViewModel.Dependencies(post: post, detailsFlow: detailsflow)
        let bindings = DetailsViewModel.Bindings()
        let detailsViewModel = DetailsViewModel(dependencies: dependencies, bindings: bindings, router: nil)
        SharingScheduler.mock(scheduler: testScheduler.scheduler) {
            let observer = testScheduler.scheduler.createObserver(UIColor.self)
            detailsViewModel.detailsTextColor.asObservable().subscribe(observer).disposed(by: disposeBag)
            testScheduler.scheduler.start()
            XCTAssertTrue(observer.events[0].value.element == UIColor.black)
        }
    }

}