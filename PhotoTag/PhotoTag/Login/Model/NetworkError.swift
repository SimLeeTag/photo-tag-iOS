//
//  NetworkError.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/03.
//

import Foundation

enum NetworkError: Error {
    
    case urlError
    case urlRequestError
    case apiError
    case jsonEncodingError
    case jsonDecodingError
    
    var message: String {
        switch self {
        case .urlError:
            return "Invalid URL"
        case .urlRequestError:
            return "Invalid URL Requset"
        case .apiError:
            return "Invalid API"
        case .jsonEncodingError, .jsonDecodingError:
            return "Invalid JSON Format"
        }
    }
}
