//
//  Endpoint.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/01.
//

import Foundation

protocol RequestProviding {
    var url: URL? { get }
    var baseUrl: String { get }
    var scheme: String { get }
    var path: Endpoint.Path { get }
}

struct Endpoint: RequestProviding {
    
    enum Path: CustomStringConvertible {
        case appleLogin
        
        var description: String {
            switch self {
            case .appleLogin:
                return "/applelogin"
            }
        }
    }
    
    // MARK: - Properties
    var url: URL? {
        var components = URLComponents()
        components.host = baseUrl
        components.scheme = scheme
        components.path = path.description
        
        return components.url
    }
    var baseUrl: String = "52.78.129.236:8080/"
    var scheme: String = "http"
    var path: Path
}
