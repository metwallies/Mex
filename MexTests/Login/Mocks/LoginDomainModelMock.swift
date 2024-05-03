//
//  LoginDomainModelMock.swift
//  MexTests
//
//  Created by islam metwally on 03.05.24.
//

import Foundation
@testable import Mex

extension LoginDomainModel {
    static var mock: LoginDomainModel {
        return LoginDomainModel(
            screenName: "Mock",
            oauthToken: "Mock",
            userId: "Mock",
            oauthTokenSecret: "Mock",
            key: "Mock",
            secret: "Mock",
            refreshToken: "Mock",
            tokenExpiresAt: nil,
            verifier: "Mock"
        )
    }
}
