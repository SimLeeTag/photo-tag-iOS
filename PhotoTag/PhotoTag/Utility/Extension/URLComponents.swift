//
//  URLComponents.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/12/22.
//

import Foundation

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
