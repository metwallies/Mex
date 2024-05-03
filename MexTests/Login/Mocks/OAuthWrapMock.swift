//
//  OAuthWrapMock.swift
//  MexTests
//
//  Created by islam metwally on 03.05.24.
//

import Foundation
@testable import Mex

enum OAuthWrapMockErrors: Error {
    case authWrapMockFailure
}

final class OAuthWrapMock: OAuthWrapping {
    var shouldSucceed = true
    func authorize(callbackURL: String) async -> Result<Mex.AuthResponse, Error> {
        if shouldSucceed {
            let user = AuthUser(
                screenName: "Mock",
                oauthToken: "Mock",
                userId: "Mock",
                oauthTokenSecret: "Mock"
            )
            let cred = AuthCredentials(
                key: "Mock",
                secret: "Mock",
                token: "Mock",
                refreshToken: "Mock",
                tokenSecret: "Mock",
                tokenExpiresAt: nil,
                verifier: "Mock"
            )
            let response = AuthResponse(user: user, credentials: cred)
            return .success(response)
        } else {
            return .failure(OAuthWrapMockErrors.authWrapMockFailure)
        }
    }
}
