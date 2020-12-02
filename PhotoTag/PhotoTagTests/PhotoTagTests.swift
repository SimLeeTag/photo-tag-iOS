//
//  PhotoTagTests.swift
//  PhotoTagTests
//
//  Created by Keunna Lee on 2020/10/20.
//

import XCTest
@testable import PhotoTag
import AuthenticationServices
import Combine

class PhotoTagTests: XCTestCase {
    
    // MARK: - Tests for TagManagementViewModel
    
    // FIXME: - always fail. Need to modify
    func testTagManagementNetwork() {
        // given
        let expectation = self.expectation(description: "활성화된 해시태그 데이터를 성공적으로 받아왔습니다.")
        // when
        let networkManager = NetworkManager()
        // 유효한 token이 필요함.
        UserDefaults.standard.setValue("test token", forKey: UserDefaultKey.key)
        let url = Endpoint(path: .fetchHashtags).url!
        let request = URLRequest(url: url)
        // then
        let a = networkManager.request(request: request)
            a.receive(subscriber: Subscribers.Sink(receiveCompletion: { [weak self] in
                guard case let .failure(error) = $0 else { return }
                debugPrint(error.localizedDescription)
                // TODO: - present alertController
            }, receiveValue: { [weak self] data in
                XCTAssertNotNil(data, "데이터가 오지 않았습니다.")
                // 디코딩이 Hashtags 타입으로 되는지 확인
                XCTAssertTrue(data is Hashtags.Type)
                expectation.fulfill()
            }))
        waitForExpectations(timeout: 8, handler: nil)
    }
    
    // FIXME: - always fail. Need to modify
    func testFetchedActivatedHashtagsCount() {
        // given
        let expectation = self.expectation(description: "해시 태그 데이터를 뷰에 표시했습니다.")
        let viewModel = TagManagementViewModel()
        // when
        // TODO: - API에서 받아온 데이터를 Mock 형태로 만들기
        // then
        
        viewModel.fetchHashtags { _ in
            // TODO: - 데이터를 받아오고 난 후 바인딩된 뷰에 업데이트 되는지 확인
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    // MARK: - Tests for TagManagementCellViewModel

}
