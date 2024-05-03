//
//  CachedLoginModelTests.swift
//  MexTests
//
//  Created by islam metwally on 03.05.24.
//

import XCTest
@testable import Mex

final class CachedLoginModelTests: XCTestCase {
    let keychainService = KeychainServiceMock()
    func testCacheLoginModelSuccess() {
        // When
        keychainService.shouldSucceed = true
        let sut = CachedLoginModelService(keychainService: keychainService)

        // Then
        let result = sut.cache(loginModel: LoginDomainModel.mock)
        var error: Error?
        switch result {
        case .success(_):
            break
        case .failure(let err):
            error = err
        }
        XCTAssertNil(error)
    }

    func testCacheLoginModelFailure() {
        // When
        keychainService.shouldSucceed = false
        let sut = CachedLoginModelService(keychainService: keychainService)

        // Then
        let result = sut.cache(loginModel: LoginDomainModel.mock)
        var error: Error?
        switch result {
        case .success(_):
            break
        case .failure(let err):
            error = err
        }
        XCTAssertNotNil(error)
    }
}
