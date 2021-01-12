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
        case fetchTagCategory
        case createNote
        
        var description: String {
            switch self {
            case .appleLogin: return "/apple-login"
            case .fetchHashtags: return "/tags/setting"
            case .patchHashtags: return "/tags/"
            case .fetchTagCategory: return "/tags/explore"
            case .createNote: return "/notes"
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
    
    static func tagCategoryFetch(withSize: Int, page: Int) -> URLComponents {
        let queryParams: [String: String] = [
            "size": "\(withSize)",
            "page": "\(page)",
            "sort": "tagName"
        ]
        return makeURL(with: queryParams, path: .fetchTagCategory)
    }
    
    static func makeURL(with parameters: [String: String], path: Path) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "52.78.129.236"
        urlComponents.path = ":8080" + path.description
        urlComponents.setQueryItems(with: parameters)
        return urlComponents
    }
}
