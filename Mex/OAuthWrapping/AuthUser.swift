//
//  AuthUser.swift
//  Mex
//
//  Created by islam metwally on 01.05.24.
//

import Foundation

final class AuthUser {
    let screenName: String
    let oauthToken: String
    let userId: String
    let oauthTokenSecret: String

    init(screenName: String, oauthToken: String, userId: String, oauthTokenSecret: String) {
        self.screenName = screenName
        self.oauthToken = oauthToken
        self.userId = userId
        self.oauthTokenSecret = oauthTokenSecret
    }

//    static var shared: AuthUser?
}
