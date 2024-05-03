//
//  LoginService.swift
//  Mex
//
//  Created by islam metwally on 01.05.24.
//

import Foundation

protocol LoginServicing {
    func login() async -> Result<LoginDomainModeling, Error>
}

struct LoginService: LoginServicing {
    private let oAuth: OAuthWrapping
    private let callbackURL: String
    
    init(oAuth: OAuthWrapping, callbackURL: String) {
        self.oAuth = oAuth
        self.callbackURL = callbackURL
    }

    func login() async -> Result<LoginDomainModeling, Error> {
        let result = await oAuth.authorize(callbackURL: callbackURL)
        switch result {
        case .success(let response):
            let loginDM = LoginDomainModel(
                screenName: response.user.screenName,
                oauthToken: response.user.oauthToken,
                userId: response.user.userId,
                oauthTokenSecret: response.user.oauthTokenSecret,
                key: response.credentials.key,
                secret: response.credentials.secret,
                refreshToken: response.credentials.refreshToken,
                tokenExpiresAt: response.credentials.tokenExpiresAt,
                verifier: response.credentials.verifier
            )
            return .success(loginDM)
        case .failure(let error):
            return .failure(error)
        }
    }
}
