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
        case fetchPhotoNoteList
        case fetchPhotoNote
        
        var description: String {
            switch self {
            case .appleLogin: return "/apple-login"
            case .fetchHashtags: return "/tags/setting"
            case .patchHashtags: return "/tags/"
            case .fetchTagCategory: return "/tags/explore"
            case .createNote: return "/notes"
            case .fetchPhotoNoteList: return "/tags"
            case .fetchPhotoNote: return "/notes/"
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
    
    var baseUrl: String = "52.78.129.236"
    var scheme: String = "http"
    var path: Path
    var tagId: TagID?
    var noteId: NoteID = 0
    
    static func hashtagPatch(path: Path, tagId: TagID) -> RequestProviding {
        var endpoint = Endpoint(path: path)
        endpoint.tagId = tagId
        return endpoint
    }
    
    static func noteFetch(noteId: NoteID) -> URLComponents {
        return makeURL(with: "\(noteId)", path: .fetchPhotoNote)
    }
    
    static func tagCategoryFetch(withSize: Int, page: Int) -> URLComponents {
        let queryParams =
            [ URLQueryItem(name: "size", value: "\(withSize)"),
              URLQueryItem(name: "page", value: "\(page)"),
              URLQueryItem(name: "sort", value: "tagName") ]
        return makeURLComponents(with: queryParams, path: .fetchTagCategory)
    }
    
    static func fetchPhotoList(tagIds: [TagID]) -> URLComponents {
        var queryItems = [URLQueryItem]()
        for tagId in tagIds {
            queryItems.append(URLQueryItem(name: "tag", value: "\(tagId)"))
        }
        return makeURLComponents(with: queryItems, path: .fetchPhotoNoteList)
    }
    
    static func makeURL(with endpoint: String, path: Path) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "52.78.129.236"
        urlComponents.path = path.description + endpoint
        return urlComponents
    }
    
    static func makeURLComponents(with parameters: [URLQueryItem], path: Path) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "52.78.129.236"
        urlComponents.path = path.description
        urlComponents.queryItems = parameters
        return urlComponents
    }
}
