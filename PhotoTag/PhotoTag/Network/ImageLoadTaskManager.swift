//
//  ImageLoadTaskManager.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/12/17.
//

import Foundation
import Combine

final class ImageLoadTaskManager {
    
    func fetchImage(with url: URL, completionHandler: @escaping (Data?) -> Void) {
        UseCase.shared.request(type: Data.self, imageUrl: url)
            .receive(subscriber: Subscribers.Sink(receiveCompletion: { [weak self] in
                guard case let .failure(error) = $0 else { return }
                debugPrint(error.localizedDescription)
            }, receiveValue: { [weak self] data in
                completionHandler(data)
            }))
    }
}
