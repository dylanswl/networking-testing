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
    }

}
