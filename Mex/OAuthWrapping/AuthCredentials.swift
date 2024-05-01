//
//  AuthCredentials.swift
//  Mex
//
//  Created by islam metwally on 01.05.24.
//

import Foundation

final class AuthCredentials {
    let key: String
    let secret: String
    let token: String
    let refreshToken: String
    let tokenSecret: String
    let tokenExpiresAt: Date?
    let verifier: String

    init(
        key: String,
        secret: String,
        token: String,
        refreshToken: String,
        tokenSecret: String,
        tokenExpiresAt: Date?,
        verifier: String
    ) {
        self.key = key
        self.secret = secret
        self.token = token
        self.refreshToken = refreshToken
        self.tokenSecret = tokenSecret
        self.tokenExpiresAt = tokenExpiresAt
        self.verifier = verifier
    }
}
