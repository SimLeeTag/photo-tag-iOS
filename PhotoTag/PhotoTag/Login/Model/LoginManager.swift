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
    let token: String
}

class LoginManager {
    
    // MARK: - properties
    var authorizationRequests: ASAuthorizationAppleIDRequest {
        let request = ASAuthorizationAppleIDProvider()
            .createRequest()
        request.requestedScopes = [.fullName,
                                   .email]
        return request
    }
    
    // MARK: - functions
    func requestAppleLoginToken(credential: ASAuthorizationAppleIDCredential) {
        guard let tokenData = credential.identityToken,
              let token = String(data: tokenData, encoding: .utf8) else { return }
        // 네트워크 요청
        UseCase.shared
            .request(data: AppleLogin(token: token),
                     endpoint: Endpoint(path: .appleLogin),
                     method: .post)
            .receive(subscriber: Subscribers.Sink(receiveCompletion: { [weak self] in
                guard case let .failure(error) = $0 else { return }
                print(#function)
                debugPrint(error.message)
                // TODO: - present alertController
            }, receiveValue: { [weak self] response in
                self?.checkResponseStatus(statusCode: response.statusCode, token: token)
            }))
    }
    
    private func checkResponseStatus(statusCode: Int, token: String) {
        if 200 <= statusCode || statusCode < 300 {
            try? saveUserInKeychain(token)
            UserDefaults.standard.set(token, forKey: UserDefaultKey.key)
        } else {
            debugPrint("유효하지 않은 Apple ID 입니다.")
        }
    }
    
    func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: "com.lena.SimLeeTag.PhotoTag", account: "userIdentifier").saveItem(userIdentifier)
        } catch {
            debugPrint("Unable to save userIdentifier to keychain.")
        }
    }
    
}
