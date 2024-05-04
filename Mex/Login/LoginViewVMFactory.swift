//
//  LoginViewVMFactory.swift
//  Mex
//
//  Created by islam metwally on 01.05.24.
//

import Foundation
import OAuthSwift
///bearer token: AAAAAAAAAAAAAAAAAAAAABlQtgEAAAAAwytJme6L%2FgtXIRdpO2QYZiyPlNM%3DHOjQkABQiw3TLLaTniXrPWiHSWSrrMzZka7zr4kbvfyI6pcABm
struct LoginViewVMFactory {

    func loginViewVM() -> LoginViewVM {

        let oAuth1: OAuth1SwiftProtocol = OAuth1Swift(
            consumerKey: TwitterToken.shared?.key ?? "",
            consumerSecret: TwitterToken.shared?.secret ?? "",
            requestTokenUrl: "https://api.twitter.com/oauth/request_token",
            authorizeUrl: "https://api.twitter.com/oauth/authorize",
            accessTokenUrl: "https://api.twitter.com/oauth/access_token"
        )
        let oAuth = OAuthWrapper(oAuth1Swift: oAuth1)
        let loginService = LoginService(oAuth: oAuth, callbackURL: "Mex://oauth-callback/twitter")
        let keychainService = KeychainService()
        let cachedLoginModelService = CachedLoginModelService(keychainService: keychainService)
        return LoginViewVM(loginService: loginService, cacheLoginModelService: cachedLoginModelService)
    }
}
