//
//  LoginServiceMock.swift
//  MexTests
//
//  Created by islam metwally on 03.05.24.
//

import Foundation
@testable import Mex

enum LoginServiceMockError: Error {
    case loginMockFailure
}

final class LoginServiceMock: LoginServicing {
    var shouldSucceed: Bool = true
    init(shouldSucceed: Bool = true) {
        self.shouldSucceed = shouldSucceed
    }

    func login() async -> Result<Mex.LoginDomainModeling, Error> {
        if shouldSucceed {
            let loginDM = LoginDomainModel.mock
            return .success(loginDM)
        } else {
            return .failure(LoginServiceMockError.loginMockFailure)
        }
    }
}

