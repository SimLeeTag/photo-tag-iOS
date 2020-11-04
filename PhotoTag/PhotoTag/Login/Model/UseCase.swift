//
//  UseCase.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/03.
//

import Foundation
import Combine

struct UseCase {
    
    // MARK: - Properties
    static let shared: UseCase = .init()
    private let decoder: JSONDecoder = .init()
    
    // MARK: - Lifecycle
    private init() { }
    
    // MARK: - Methods
    func request<E: Encodable>(_ network: NetworkConnectable = NetworkManager.shared, data: E, endpoint: RequestProviding, method: HTTPMethod) -> AnyPublisher<HTTPURLResponse, NetworkError> {
        guard let url = endpoint.url else {
            return Fail(error: NetworkError.urlError).eraseToAnyPublisher()
        }
        guard let data = try? JSONEncoder().encode(data) else {
            return Fail(error: NetworkError.jsonEncodingError).eraseToAnyPublisher()
        }
        
        return network
            .request(request: URLRequest(url: url,
                                         method: method,
                                         body: data))
            .compactMap { $0.response as? HTTPURLResponse }
            .mapError { _ in NetworkError.jsonDecodingError }
            .eraseToAnyPublisher()
    }
}
