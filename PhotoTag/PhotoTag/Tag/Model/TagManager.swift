//
//  TagManager.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/25.
//

import Foundation
import Combine

class TagNetworkManager {
    func fetchHashtags(completionHandler: @escaping (Hashtags?) -> Void) {
        
        UseCase.shared
            .request(type: Hashtags.self, endpoint: Endpoint(path: .fetchHashtags), method: .get)
            .receive(subscriber: Subscribers.Sink(receiveCompletion: { [weak self] in
                guard case let .failure(error) = $0 else { return }
                debugPrint(error.localizedDescription)
                // TODO: - present alertController
            }, receiveValue: { [weak self] data in
                completionHandler(data)
            }))
    }
}
