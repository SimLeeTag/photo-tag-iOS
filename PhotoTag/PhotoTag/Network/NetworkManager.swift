//
//  NetworkManager.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/03.
//

import Foundation
import Combine

protocol NetworkConnectable {
    var session: URLSession { get }
    func request(request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), NetworkError>
}

struct NetworkManager: NetworkConnectable {
    
    // MARK: - Properties
    static var shared: NetworkManager = .init()
    var session: URLSession
    
    // MARK: - Lifecycle
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Methods
    func request(request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), NetworkError> {
        session.dataTaskPublisher(for: request)
            .mapError { _ in NetworkError.apiError }
            .map {  data, response in return (data, response) }
            .eraseToAnyPublisher()
    }
}
