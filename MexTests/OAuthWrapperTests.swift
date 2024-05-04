//
//  OAuthWrapperTests.swift
//  MexTests
//
//  Created by islam metwally on 04.05.24.
//

import XCTest
@testable import Mex

final class OAuthWrapperTests: XCTestCase {
    func testAuthorizeSuccess() async {
        // When
        let mockOAuth1Swift = OAuth1SwiftMock()
        mockOAuth1Swift.shouldSucceed = true
        let sut = OAuthWrapper(oAuth1Swift: mockOAuth1Swift)

        // Then
        let result = await sut.authorize(callbackURL: "Mex://oauth-callback/twitter")
        var response: AuthResponse? = nil
        switch result {
        case .success(let res):
            response = res
        case .failure(_):
            response = nil
        }
        XCTAssertNotNil(response)
    }

    func testAuthorizeFailure() async {
        // When
        let mockOAuth1Swift = OAuth1SwiftMock()
        mockOAuth1Swift.shouldSucceed = false
        let sut = OAuthWrapper(oAuth1Swift: mockOAuth1Swift)

        // Then
        let result = await sut.authorize(callbackURL: "Mex://oauth-callback/twitter")
        var response: AuthResponse? = nil
        switch result {
        case .success(let res):
            response = res
        case .failure(_):
            response = nil
        }
        XCTAssertNil(response)
    }
}
