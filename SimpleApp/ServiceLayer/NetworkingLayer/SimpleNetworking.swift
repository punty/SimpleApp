//
//  SimpleNetworking.swift
//  SimpleConverter
//
//  Created by Francesco Puntillo on 09/11/2016.
//  Copyright © 2016 Francesco Puntillo. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case dataError
    case networkError
}

protocol ServiceClientType {
    func get<T: Codable>(api: API, completion: @escaping (Result<T, ServiceError>) -> Void) -> URLSessionTask
}

final class ServiceClient: ServiceClientType {
    
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(15)
        configuration.timeoutIntervalForResource = TimeInterval(15)
        return URLSession(configuration: configuration)
    }()
    
    
    func get<T: Codable>(api: API, completion: @escaping (Result<T, ServiceError>) -> Void) -> URLSessionTask {
        return session.dataTask(with: api.asURLRequest()) { data, _, error in
            guard let unwrappedData = data else {
                completion(.failure(.networkError))
                return
            }
            do {
                let obj = try JSONDecoder().decode(T.self, from: unwrappedData)
                completion(.success(obj))
            } catch {
                completion(.failure(.dataError))
            }
        }
    }
}
