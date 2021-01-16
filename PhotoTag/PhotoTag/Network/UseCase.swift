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
    
    // MARK: - Functions
    func request<E: Encodable>(_ network: NetworkConnectable = NetworkManager.shared,
                               data: E,
                               endpoint: RequestProviding,
                               method: HTTPMethod) -> AnyPublisher<HTTPURLResponse, NetworkError> {
        guard let url = endpoint.url else {
            return Fail(error: NetworkError.urlError).eraseToAnyPublisher()
        }
        guard let data = try? JSONEncoder().encode(data) else {
            return Fail(error: NetworkError.jsonEncodingError).eraseToAnyPublisher()
        }
        
        return network
            .request(request: URLRequest(urlWithToken: url,
                                         method: method,
                                         body: data))
            .compactMap { $0.response as? HTTPURLResponse }
            .mapError { _ in NetworkError.jsonDecodingError }
            .eraseToAnyPublisher()
    }
    
    // send file
    func request(_ network: NetworkConnectable = NetworkManager.shared,
                 request: URLRequest) -> AnyPublisher<HTTPURLResponse, NetworkError> {
        return network
            .request(request: request)
            .compactMap { $0.response as? HTTPURLResponse }
            .mapError { _ in NetworkError.jsonDecodingError }
            .eraseToAnyPublisher()
    }
    
    func request<D: Decodable>(_ network: NetworkConnectable = NetworkManager.shared,
                               type: D.Type, endpoint: RequestProviding,
                               method: HTTPMethod) -> AnyPublisher<D, Error> {
        guard let url = endpoint.url else {
            return Fail(error: NetworkError.urlError).eraseToAnyPublisher()
        }
        
        return network
            .session
            .dataTaskPublisher(for: URLRequest(urlWithToken: url, method: method))
            .map { $0.data }
            .decode(type: D.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    // using URLComponents
    func request<D: Decodable>(_ network: NetworkConnectable = NetworkManager.shared,
                               type: D.Type, urlComponents: URLComponents,
                               method: HTTPMethod) -> AnyPublisher<D, Error> {
        guard let url = urlComponents.url else {
            return Fail(error: NetworkError.urlError).eraseToAnyPublisher()
        }
        
        return network
            .session
            .dataTaskPublisher(for: URLRequest(urlWithToken: url, method: method))
            .map { $0.data }
            .decode(type: D.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
}
