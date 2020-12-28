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
    
    func testUpdatedHashtagCount() {
        // given
        let mockHashtags = makeMockHashtags()
        let viewModel = makeMockViewModel(with: mockHashtags)
        // when
        // 3 in each array
        let activatedCount = viewModel.updatedHashtagCount(of: .activated) 
        let archivedCount = viewModel.updatedHashtagCount(of: .archived)
        
        // then
        XCTAssertTrue(activatedCount == 3
                      , "활성화된 해시태그의 수가 정상적으로 반영되었습니다.")
        XCTAssertTrue(archivedCount == 3
                      , "보관된(비활성화된) 해시태그의 수가 정상적으로 반영되었습니다.")
    }
    
    // archived(비활성화) -> activated(활성화)
    func testSuccessToRestoreHashtag() {
        // given
        let mockHashtags = makeMockHashtags()
        let viewModel = makeMockViewModel(with: mockHashtags)
        let tagId = mockHashtags.tagIdList[4]
        // 비교용(확인용) Array. Restore 후 이 배열이 되어야 함.
        let updatedActivatedList = makeMockListAfterRestoring(with: mockHashtags).activatedList // count is 4
        let updateArchivedList = makeMockListAfterRestoring(with: mockHashtags).archivedList // count is 2
        
        // when
        viewModel.updateHashtagState(tagId: tagId, willBe: .activated)
        let activatedHashtagCount = viewModel.updatedHashtagCount(of: .activated) // count would be 4
        let archivedHashtagCount = viewModel.updatedHashtagCount(of: .archived) // count would be 2
        
        // then
        // compare
        XCTAssertEqual(updatedActivatedList, viewModel.activatedHashtags.value
                       , "활성화된(Activated) 해시태그 배열이 성공적으로 업데이트 되었습니다.")
        XCTAssertEqual(updateArchivedList, viewModel.archivedHashtags.value
                       , "비활성화된(Archived) 해시태그 배열이 성공적으로 업데이트 되었습니다.")
        
        // check count
        XCTAssertEqual(activatedHashtagCount, 4
                       , "해시태그를 Archived List에서 Activated List로 Restore한 후 활성화된(Activated) 해시태그의 수가 하나 더해져 4가 되었습니다")
        XCTAssertEqual(archivedHashtagCount, 2
                       , "비활성화된(Archived) 해시태그의 수가 하나 줄어들어 2가 되었습니다")
        
        // check whether the tag is included or not
        XCTAssertTrue(viewModel.activatedHashtags.value
                        .map{$0.tagID}
                        .contains(tagId)
                      , "Restore한 태그가 활성화된(Activated) 해시태그 배열에 추가되었고 현재 해당 태그의 아이디를 가진 value가 배열에 존재합니다")
        XCTAssertFalse(viewModel.archivedHashtags.value
                        .map{$0.tagID}
                        .contains(tagId)
                       , "Restore한 태그가 비활성화된(Archived) 해시태그 배열에서 삭제되었고, 현재 해당 태그의 아이디를 가진 value가 배열에 존재하지 않습니다")
    }
    
    // archived(비활성화) -> activated(활성화)
    func testFailToRestoreHashtag() { // with non-existent tag ID
        // given
        let mockHashtags = makeMockHashtags()
        let viewModel = makeMockViewModel(with: mockHashtags)
        let newTagIdList = mockHashtags.tagIdList.map{$0 + 1}
        let nonExistentTagId = newTagIdList[0] // 존재하지 않는 태그 아이디
        let updatedActivatedList = makeMockListAfterRestoring(with: mockHashtags).activatedList // count would be 4
        let updateArchivedList = makeMockListAfterRestoring(with: mockHashtags).archivedList // count would be 2
        
        // when
        viewModel.updateHashtagState(tagId: nonExistentTagId, willBe: .activated)
        let activatedHashtagCount = viewModel.updatedHashtagCount(of: .activated)
        let archivedHashtagCount = viewModel.updatedHashtagCount(of: .archived)
        
        // then
        // compare
        XCTAssertNotEqual(updatedActivatedList, viewModel.activatedHashtags.value
                       , "유효하지 않거나 권한이 없는 태그이기 때문에 활성화된(Activated) 해시태그 배열에 업데이트 되지 않았습니다.")
        XCTAssertNotEqual(updateArchivedList, viewModel.archivedHashtags.value
                       , "유효하지 않거나 권한이 없는 태그이기 때문에 비활성화된(Archived) 해시태그 배열에 업데이트 되지 않았습니다.")
        
        // check count
        XCTAssertEqual(activatedHashtagCount, 3
                       , "활성화된(Activated) 해시태그 배열의 카운트가 변경되지 않고 기존 mock 데이터의 카운트를 유지합니다.")
        XCTAssertEqual(archivedHashtagCount, 3
                       , "비활성화된(Archived) 해시태그 배열의 카운트가 변경되지 않고 기존 mock 데이터의 카운트를 유지합니다.")
        
        // check whether the tag is included or not
        XCTAssertFalse(viewModel.activatedHashtags.value
                        .map{$0.tagID}
                        .contains(nonExistentTagId)
                      , "활성화된(Activated) 해시태그 배열에 해당 태그 아이디를 가진 해시태그가 존재하지 않습니다.")
        XCTAssertFalse(viewModel.archivedHashtags.value
                        .map{$0.tagID}
                        .contains(nonExistentTagId)
                       , "비활성화된(Archived) 해시태그 배열에 해당 태그 아이디를 가진 해시태그가 존재하지 않습니다.")
    }
    
    // activated(활성화) -> archived(비활성화)
    func testSuccessToArchiveHashtag() {
        // given
        let mockHashtags = makeMockHashtags()
        let viewModel = makeMockViewModel(with: mockHashtags)
        let tagId = mockHashtags.tagIdList[0]
        // 비교용(확인용) Array. Archive 후 이 배열이 되어야 함.
        let updatedActivatedList = makeMockListAfterArchiving(with: mockHashtags).activatedList // count is 2
        let updateArchivedList = makeMockListAfterArchiving(with: mockHashtags).archivedList // count is 4
        
        // when
        viewModel.updateHashtagState(tagId: tagId, willBe: .archived)
        let activatedHashtagCount = viewModel.updatedHashtagCount(of: .activated) // count would be 2
        let archivedHashtagCount = viewModel.updatedHashtagCount(of: .archived) // count would be 4
        
        // then
        // compare
        XCTAssertEqual(updatedActivatedList, viewModel.activatedHashtags.value
                       , "활성화된(Activated) 해시태그 배열이 성공적으로 업데이트 되었습니다.")
        XCTAssertEqual(updateArchivedList, viewModel.archivedHashtags.value
                       , "비활성화된(Archived) 해시태그 배열이 성공적으로 업데이트 되었습니다.")
        
        // check count
        XCTAssertEqual(activatedHashtagCount, 2
                       , "해시태그를 Archived List에서 Activated List로 Restore한 후 활성화된(Activated) 해시태그의 수가 하나 줄어들어 2가 되었습니다")
        XCTAssertEqual(archivedHashtagCount, 4
                       , "비활성화된(Archived) 해시태그의 수가 하나 늘어나 4가 되었습니다")
        
        // check whether the tag is included or not
        XCTAssertFalse(viewModel.activatedHashtags.value
                        .map{$0.tagID}
                        .contains(tagId)
                      , "Archive한 태그가 활성화된(Activated) 해시태그 배열에서 삭제되었고 현재 해당 태그의 아이디를 가진 value가 배열에 존재하지 않습니다")
        XCTAssertTrue(viewModel.archivedHashtags.value
                        .map{$0.tagID}
                        .contains(tagId)
                       , "Archive한 태그가 비활성화된(Archived) 해시태그 배열에 추가되었고, 현재 해당 태그의 아이디를 가진 value가 배열에 존재합니다")
    }
    
    // archived(비활성화) -> activated(활성화)
    func testFailToArchiveHashtag() { // with non-existent tag ID
        // given
        let mockHashtags = makeMockHashtags()
        let viewModel = makeMockViewModel(with: mockHashtags)
        let newTagIdList = mockHashtags.tagIdList.map{$0 + 1}
        let nonExistentTagId = newTagIdList[0] // 존재하지 않는 태그 아이디
        let updatedActivatedList = makeMockListAfterRestoring(with: mockHashtags).activatedList // count would be 4
        let updateArchivedList = makeMockListAfterRestoring(with: mockHashtags).archivedList // count would be 2
        
        // when
        viewModel.updateHashtagState(tagId: nonExistentTagId, willBe: .activated)
        let activatedHashtagCount = viewModel.updatedHashtagCount(of: .activated)
        let archivedHashtagCount = viewModel.updatedHashtagCount(of: .archived)
        
        // then
        // compare
        XCTAssertNotEqual(updatedActivatedList, viewModel.activatedHashtags.value
                       , "유효하지 않거나 권한이 없는 태그이기 때문에 활성화된(Activated) 해시태그 배열에 업데이트 되지 않았습니다.")
        XCTAssertNotEqual(updateArchivedList, viewModel.archivedHashtags.value
                       , "유효하지 않거나 권한이 없는 태그이기 때문에 비활성화된(Archived) 해시태그 배열에 업데이트 되지 않았습니다.")
        
        // check count
        XCTAssertEqual(activatedHashtagCount, 3
                       , "활성화된(Activated) 해시태그 배열의 카운트가 변경되지 않고 기존 mock 데이터의 카운트를 유지합니다.")
        XCTAssertEqual(archivedHashtagCount, 3
                       , "비활성화된(Archived) 해시태그 배열의 카운트가 변경되지 않고 기존 mock 데이터의 카운트를 유지합니다.")
        
        // check whether the tag is included or not
        XCTAssertFalse(viewModel.activatedHashtags.value
                        .map{$0.tagID}
                        .contains(nonExistentTagId)
                      , "활성화된(Activated) 해시태그 배열에 해당 태그 아이디를 가진 해시태그가 존재하지 않습니다.")
        XCTAssertFalse(viewModel.archivedHashtags.value
                        .map{$0.tagID}
                        .contains(nonExistentTagId)
                       , "비활성화된(Archived) 해시태그 배열에 해당 태그 아이디를 가진 해시태그가 존재하지 않습니다.")
    }
    
    // MARK: - Network
    func testMakeUrl() {
        // given
        let queryParams: [String: String] = [
            "size": "\(12)",
            "page": "\(0)",
            "sort": "tagName"
        ]
        // when
        let url = Endpoint.makeURL(with: queryParams, path: .fetchTagCategory)
        let expectedUrl = URLComponents(string: "http://52.78.129.236:8080/tags/explore?size=12&page=0&sort=tagName")
        // then
        XCTAssertEqual(url.host, expectedUrl?.host, "url의 host가 일치합니다")
        XCTAssertEqual(url.path, ":8080" + expectedUrl!.path, "url의 path와 일치합니다")
        XCTAssertEqual(url.queryItems?.count, expectedUrl?.queryItems?.count, "url의 query의 수가 일치합니다")
        XCTAssertEqual(url.scheme, expectedUrl?.scheme, "url의 scheme이 일치합니다")
    }
    
    func testMakeTagCategoryRequestUrl() {
        // given
        let queryParams: [String: String] = [
            "size": "\(12)",
            "page": "\(0)",
            "sort": "tagName"
        ]
        let expectedUrl = Endpoint.makeURL(with: queryParams, path: .fetchTagCategory)
        // when
        let url = Endpoint.tagCategoryFetch(withSize: 12, page: 0)
        
        // then
        XCTAssertEqual(expectedUrl, url, "query를 이용한 정상적인 URL 생성했습니다.")
    }
}

extension PhotoTagTests {
    
    private func makeMockHashtags() -> MockHashtags {
        return MockHashtags()
    }
    
    private func makeMockViewModel(with mock: MockHashtags) -> TagManagementViewModel {
        let tagManagementViewModel = TagManagementViewModel()
        var mockHashtags = mock
        let mockData = mockHashtags.makeMokeHashtags() // 3 in each array
        tagManagementViewModel.activatedHashtags.value = mockData.activatedList
        tagManagementViewModel.archivedHashtags.value = mockData.archivedList
        return tagManagementViewModel
    }
    
    private func makeMockListAfterRestoring(with mock: MockHashtags) -> Hashtags {
        var mockHashtags = MockHashtags()
        let tagId = mockHashtags.tagIdList[4]
        let mockData = mockHashtags.makeMokeHashtags() // 3 in each array
        guard var tagToMove = mockData.archivedList.filter({$0.tagID == tagId}).first else { return Hashtags(activatedList: [], archivedList: [])}
        let updatedArchivedList = mockData.archivedList
                                           .map{$0}
                                           .filter{$0.tagID != tagId } // the count become 2
        var updatedActivatedList = mockData.activatedList.map{$0}
        tagToMove.activated = true
        updatedActivatedList.append(tagToMove)// the count become 4
        
        return Hashtags(activatedList: updatedActivatedList, archivedList: updatedArchivedList)
    }
    
    private func makeMockListAfterArchiving(with mock: MockHashtags) -> Hashtags {
        var mockHashtags = MockHashtags()
        let tagId = mockHashtags.tagIdList[0]
        let mockData = mockHashtags.makeMokeHashtags() // 3 in each array
        guard var tagToMove = mockData.activatedList.filter({$0.tagID == tagId}).first else { return Hashtags(activatedList: [], archivedList: [])}
        let updatedActivatedList = mockData.activatedList
                                           .map{$0}
                                           .filter{$0.tagID != tagId } // the count become 2
        var updatedArchivedList = mockData.archivedList.map{$0}
        tagToMove.activated = false
        updatedArchivedList.append(tagToMove)// the count become 4
        
        return Hashtags(activatedList: updatedActivatedList, archivedList: updatedArchivedList)
    }
}


