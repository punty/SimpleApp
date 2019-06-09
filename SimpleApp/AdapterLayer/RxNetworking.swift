//
//  RxNetworking.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 09/06/2019.
//  Copyright © 2019 FP. All rights reserved.
//

import Foundation
import RxSwift

extension ServiceClientType {
    func get<T: Codable>(api: API) -> Observable <T> {
        return Observable.create { obs in
           let task = self.get(api: api) { (result: Result<T, ServiceError>) in
                switch result {
                case .success(let item):
                    obs.onNext(item)
                    obs.onCompleted()
                case .failure(let error):
                    obs.onError(error)
                }
            }
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
