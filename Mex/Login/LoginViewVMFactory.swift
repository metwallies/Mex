//
//  LoginViewVMFactory.swift
//  Mex
//
//  Created by islam metwally on 01.05.24.
//

import Foundation
///bearer token: AAAAAAAAAAAAAAAAAAAAABlQtgEAAAAAwytJme6L%2FgtXIRdpO2QYZiyPlNM%3DHOjQkABQiw3TLLaTniXrPWiHSWSrrMzZka7zr4kbvfyI6pcABm
struct LoginViewVMFactory {

    func loginViewVM() -> LoginViewVM {

        let oAuth = OAuthWrapper(
            consumerKey: TwitterToken.shared?.key ?? "",
            consumerSecret: TwitterToken.shared?.secret ?? "",
            requestToken: "https://api.twitter.com/oauth/request_token",
            authoriseUrl: "https://api.twitter.com/oauth/authorize",
            accessToken: "https://api.twitter.com/oauth/access_token"
        )
        let loginService = LoginService(oAuth: oAuth, callbackURL: "Mex://oauth-callback/twitter")
        let keychainService = KeychainService()
        let cachedLoginModelService = CachedLoginModelService(keychainService: keychainService)
        return LoginViewVM(loginService: loginService, cacheLoginModelService: cachedLoginModelService)
    }
}
