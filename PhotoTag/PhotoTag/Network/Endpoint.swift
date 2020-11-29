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
        case fetchHashtags
        
        var description: String {
            switch self {
            case .appleLogin: return "/applelogin"
            case .fetchHashtags: return "/tags/setting"
            }
        }
    }
    
    // MARK: - Properties
    var url: URL? {
        var components = URLComponents()
        return URL(string: scheme + "://" + baseUrl + path.description)
    }
    var baseUrl: String = "52.78.129.236:8080"
    var scheme: String = "http"
    var path: Path
}
