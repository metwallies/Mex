//
//  AuthResponse.swift
//  Mex
//
//  Created by islam metwally on 01.05.24.
//

import Foundation

final class AuthResponse {
    let user: AuthUser
    let credentials: AuthCredentials

    init(user: AuthUser, credentials: AuthCredentials) {
        self.user = user
        self.credentials = credentials
    }
}
