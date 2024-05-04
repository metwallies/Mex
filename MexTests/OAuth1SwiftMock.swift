//
//  OAuth1SwiftMock.swift
//  MexTests
//
//  Created by islam metwally on 04.05.24.
//

import Foundation
import OAuthSwift
@testable import Mex

final class OAuth1SwiftMock: OAuth1SwiftProtocol {
    var shouldSucceed = true
    func authorize(
        withCallbackURL: String,
        completionHandler: @escaping OAuth1Swift.TokenCompletionHandler
    ) {
        if shouldSucceed {
            let cred = OAuthSwiftCredential(
                consumerKey: "Mock",
                consumerSecret: "Mock"
            )
            let params = ["screen_name": "Mock", "oauth_token": "Mock", "user_id": "Mock", "oauth_token_secret": "Mock"]
            let response: OAuthSwiftResponse? = nil
            let tokenSuccess = (cred, response , params)
            completionHandler(.success(tokenSuccess))
        } else {
            completionHandler(.failure(OAuthSwiftError.cancelled))
        }
    }
}
