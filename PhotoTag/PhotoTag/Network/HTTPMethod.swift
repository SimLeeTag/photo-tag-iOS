//
//  HTTPMethod.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/03.
//

import Foundation

enum HTTPMethod: CustomStringConvertible {
    
    case get
    case put
    case post
    case delete
    case patch
    
    var description: String {
        switch self {
        case .get:
            return "GET"
        case .put:
            return "PUT"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        case .patch:
            return "PATCH"
        }
    }
}
