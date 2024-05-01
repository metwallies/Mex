//
//  LoginDomainModel.swift
//  Mex
//
//  Created by islam metwally on 02.05.24.
//

import Foundation

protocol LoginDomainModeling {
    var screenName: String  { get }
    var oauthToken: String { get }
    var userId: String { get }
    var oauthTokenSecret: String { get }
    var key: String { get }
    var secret: String { get }
    var refreshToken: String { get }
    var tokenExpiresAt: Date? { get }
    var verifier: String { get }
}

struct LoginDomainModel: LoginDomainModeling {
    let screenName: String
    let oauthToken: String
    let userId: String
    let oauthTokenSecret: String
    let key: String
    let secret: String
    let refreshToken: String
    let tokenExpiresAt: Date?
    let verifier: String
}
