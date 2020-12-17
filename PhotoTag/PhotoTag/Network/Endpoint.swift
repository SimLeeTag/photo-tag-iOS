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
        case patchHashtags
        
        var description: String {
            switch self {
            case .appleLogin: return "/apple-login"
            case .fetchHashtags: return "/tags/setting"
            case .patchHashtags: return "/tags/"
            }
        }
    }
    
    // MARK: - Properties
    var url: URL? {
        if tagId == nil {
            return URL(string: scheme + "://" + baseUrl + path.description)
        }
        return URL(string: scheme + "://" + baseUrl + path.description + "\(tagId!)")
    }
    
    var urlWithTagId: URL? {
        return URL(string: scheme + "://" + baseUrl + path.description + "\(tagId!)")
    }
    var baseUrl: String = "52.78.129.236:8080"
    var scheme: String = "http"
    var path: Path
    var tagId: Int?
    
    static func hashtagPatch(path: Path, tagId: Int) -> RequestProviding {
        var endpoint = Endpoint(path: path)
        endpoint.tagId = tagId
        return endpoint
    }
}
