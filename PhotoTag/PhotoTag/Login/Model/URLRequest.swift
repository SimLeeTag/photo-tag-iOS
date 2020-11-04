//
//  URLRequest.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/03.
//

import Foundation

extension URLRequest {
    init(url: URL, method: HTTPMethod, body: Data? = nil) {
        self.init(url: url)
        self.httpMethod = method.description
        self.setValue("application/json",
                      forHTTPHeaderField: "Content-Type")
        self.setValue("Bearer " + KeychainItem.currentUserIdentifier,
                      forHTTPHeaderField: "Authorization")
        self.setValue(UserDefaults.standard.object(forKey: "loginType") as? String,
                      forHTTPHeaderField: "loginType")
        self.httpBody = body
    }
}
