//
//  TagNetworkingManager.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/11/25.
//

import Foundation
import Combine

struct HastagState: Codable {
    let activated: Bool // true = activated
}

final class TagNetworkingManager {
    
    // MARK: - Tag Management
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
    
    func updateHashtagActivatedState(of tagId: Int, with data: HastagState) {
        UseCase.shared.request(data: data,
                               endpoint: Endpoint.hashtagPatch(path: .patchHashtags, tagId: tagId),
                               method: .patch)
            .receive(subscriber: Subscribers.Sink(receiveCompletion: { [weak self] in
                guard case let .failure(error) = $0 else { return }
                debugPrint(error.message)
            }, receiveValue: { [weak self] response in
                self?.checkResponseStatus(statusCode: response.statusCode)
            }))
    }
    
    // MARK: - Tag Category
    func fetchTagsWithImage(size: Int, page: Int,
                            completionHandler: @escaping ([Tag]?) -> Void) {
        // /tags/explore?size=12&page=0&sort=tagName
        UseCase.shared
            .request(type: [Tag].self, endpoint: Endpoint(path: .fetchHashtags), method: .get)
            .receive(subscriber: Subscribers.Sink(receiveCompletion: { [weak self] in
                guard case let .failure(error) = $0 else { return }
                debugPrint(error.localizedDescription)
            }, receiveValue: { [weak self] data in
                completionHandler(data)
            }))
    }
    
    // MARK: - Message
    private func checkResponseStatus(statusCode: Int) {
        if 200 == statusCode {
            debugPrint("요청이 성공했습니다")
        } else if 204 == statusCode{
            debugPrint("No Content. 콘텐츠가 없습니다")
        } else if 401 == statusCode {
            debugPrint("Unauthorized. 권한이 없습니다")
        } else if 403 == statusCode {
            debugPrint("Forbidden. 잘못된 접근입니다")
        } else {
            debugPrint("알 수 없는 이유로 요청이 실패했습니다.")
        }
    }
}
