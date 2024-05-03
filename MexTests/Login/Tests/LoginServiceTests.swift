//
//  LoginServiceTests.swift
//  MexTests
//
//  Created by islam metwally on 03.05.24.
//

import XCTest
@testable import Mex

final class LoginServiceTests: XCTestCase {
    let oauth = OAuthWrapMock()

    func testLoginSuccess() {
        //when
        oauth.shouldSucceed = true
        let sut: LoginService = LoginService(oAuth: oauth, callbackURL: "Mock")

        //then
        Task {
            let result = await sut.login()
            var loginDM: LoginDomainModeling?
            switch result {
            case .success(let success):
                loginDM = success
            case .failure(_):
                loginDM = nil
            }
            XCTAssertNotEqual(loginDM as? LoginDomainModel, nil)
        }
    }

    func testLoginFailure() {
        //when
        oauth.shouldSucceed = false
        let sut: LoginService = LoginService(oAuth: oauth, callbackURL: "Mock")

        //then
        Task {
            let result = await sut.login()
            var loginDM: LoginDomainModeling?
            switch result {
            case .success(let success):
                loginDM = success
            case .failure(_):
                loginDM = nil
            }
            XCTAssertEqual(loginDM as? LoginDomainModel, nil)
        }
    }
}
