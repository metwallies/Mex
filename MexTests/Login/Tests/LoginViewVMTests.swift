//
//  LoginViewVMTests.swift
//  MexTests
//
//  Created by islam metwally on 03.05.24.
//

import XCTest
@testable import Mex

final class LoginViewVMTests: XCTestCase {
    let loginServiceMock = LoginServiceMock()
    let cachedLoginMock = CachedLoginServiceMock()

    func testOnTouchDownCTASuccess() async {
        //When
        loginServiceMock.shouldSucceed = true
        cachedLoginMock.shouldSucceed = true

        let sut = LoginViewVM(
            loginService: loginServiceMock,
            cacheLoginModelService: cachedLoginMock
        )
        let appVM = MexAppViewModelLoginListenerMock()

        await sut.onDidTouchDownCTA(app: appVM)
        //Then
        XCTAssert(appVM.didSuccessfullyLogin == true)

    }

    func testOnTouchDownCTAFailure() async {
        //When
        loginServiceMock.shouldSucceed = false
        cachedLoginMock.shouldSucceed = false

        let sut = LoginViewVM(
            loginService: loginServiceMock,
            cacheLoginModelService: cachedLoginMock
        )
        let appVM = MexAppViewModelLoginListenerMock()
        await sut.onDidTouchDownCTA(app: appVM)
        //Then
        assert(appVM.didSuccessfullyLogin == false)
    }
}
