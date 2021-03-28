//
//  URLRequest.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/03.
//

import Foundation

extension URLRequest {
    init(baseUrl: URL, method: HTTPMethod, body: Data? = nil) {
        self.init(url: baseUrl)
        self.httpMethod = method.description
        self.setValue("application/json",
                      forHTTPHeaderField: "Content-Type")
        self.setValue("application/json", forHTTPHeaderField: "Accept")
        
        self.httpBody = body
    }
    
    init(urlWithToken: URL, method: HTTPMethod, body: Data? = nil) {
        self.init(url: urlWithToken)
        self.httpMethod = method.description
        self.setValue("application/json",
                      forHTTPHeaderField: "Content-Type")
        self.setValue("Bearer " + UserDefaults.standard.string(forKey: UserDefaultKey.userId)!, forHTTPHeaderField: "Authorization")
        
        self.httpBody = body
    }
    
    // with request body
    init(urlWithToken: URL, method: HTTPMethod, body: Data, jsonKey: String) {
        self.init(url: urlWithToken)
        let json = [jsonKey: body]
        let jsonData = try? JSONEncoder().encode(json)
        self.httpMethod = method.description
        self.setValue("application/json",
                      forHTTPHeaderField: "Content-Type")
        self.setValue("Bearer " + UserDefaults.standard.string(forKey: UserDefaultKey.userId)!, forHTTPHeaderField: "Authorization")
        self.httpBody = jsonData!
    }
}
