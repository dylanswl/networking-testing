//
//  ViewControllerTests.swift
//  NetworkRequestTests
//
//  Created by Dylan Sewell on 2/17/22.
//

import XCTest
@testable import NetworkRequest

class ViewControllerTests: XCTestCase {

    func test_tappingButton_shouldMakeDataTaskToSearchForEBookOutFromBonneville() {
        let sut = ViewController()
        let mockURLSession = MockURLSession()
        sut.session = mockURLSession
        sut.loadViewIfNeeded()
        
        tap(sut.button)
        
        mockURLSession.verifyDataTask(with: URLRequest(url: URL(string: "https://itunes.apple.com/search?media=ebook&term=out%20from%20bonneville")!))
    }
    
    func test_searchForBookNetworkCall_withSuccessResponse_shouldSaveDataInResults() {
        let sut = ViewController()
        let session = MockURLSession()
        sut.session = session
        sut.loadViewIfNeeded()
        
        tap(sut.button)
        
        let handleResultsCalled = expectation(description: "handleResults called")
        
        sut.handleResults = { _ in
            handleResultsCalled.fulfill()
        }
        
        session.dataTaskArgsCompletionHandler.first?(jsonData(), response(statusCode: 200), nil)
        
        waitForExpectations(timeout: 0.01)
        
        XCTAssertEqual(sut.results, [
            SearchResult(
                artistName: "Artist",
                trackName: "Track",
                averageUserRating: 2.5,
                genres: ["Foo", "Bar"])
        ])
        
    }
    
    func test_searchForBookNetworkCall_withSuccessBeforeAsync_shouldNOtSaveDataInResults() {
        let sut = ViewController()
        let session = MockURLSession()
        sut.session = session
        sut.loadViewIfNeeded()
        
        tap(sut.button)
        
        session.dataTaskArgsCompletionHandler.first?(jsonData(), response(statusCode: 200), nil)
                
        XCTAssertEqual(sut.results, [])
        
    }

    private func jsonData() -> Data {
        """
        
        {
            "results": [
                {
                    "artistName": "Artist",
                    "trackName": "Track",
                    "averageUserRating": 2.5,
                    "genres": [
                        "Foo",
                        "Bar"
                    ]
                }
            ]
        }
        """.data(using: .utf8)!
    }
    
    private func response(statusCode: Int) -> HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: "http://DUMMY")!,
                        statusCode: statusCode,
                        httpVersion: nil,
                        headerFields: nil)
    }
}

