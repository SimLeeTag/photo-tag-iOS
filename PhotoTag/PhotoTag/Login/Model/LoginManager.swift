//
//  LoginManager.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/01.
//

import Foundation
import AuthenticationServices
import Combine

struct AppleLogin: Codable {
    let jwtToken: String
}

final class LoginManager {
    
    // MARK: - properties
    var authorizationRequests: ASAuthorizationAppleIDRequest {
        let request = ASAuthorizationAppleIDProvider()
            .createRequest()
        request.requestedScopes = [.fullName,
                                   .email]
        return request
    }
    
    // MARK: - Functions
    func requestAppleLoginToken(credential: ASAuthorizationAppleIDCredential) {
        guard let tokenData = credential.identityToken,
              let token = String(data: tokenData, encoding: .utf8) else { return }
        UserDefaults.standard.setValue(token, forKey: UserDefaultKey.userId)
        UseCase.shared
            .request(data: AppleLogin(jwtToken: token),
                     endpoint: Endpoint(path: .appleLogin),
                     method: .post)
            .receive(subscriber: Subscribers.Sink(receiveCompletion: { [weak self] in
                guard case let .failure(error) = $0 else { return }
                debugPrint(error.message)
                // TODO: - present alertController
            }, receiveValue: { [weak self] response in
                self?.checkResponseStatus(statusCode: response.statusCode, token: token)
               
            }))
    }
    
    private func checkResponseStatus(statusCode: Int, token: String) {
        if 200 <= statusCode || statusCode < 300 {
            UserDefaults.standard.set(token, forKey: UserDefaultKey.userId)
        } else {
            debugPrint("유효하지 않은 Apple ID 입니다.")
        }
    }
    
}
