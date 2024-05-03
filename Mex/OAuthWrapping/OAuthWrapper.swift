//
//  OAuth.swift
//  Mex
//
//  Created by islam metwally on 01.05.24.
//

import Foundation
import OAuthSwift

protocol OAuthWrapping {
    func authorize(callbackURL: String) async -> Result<AuthResponse, Error>
}

enum OAuthWrappingError: Error {
    case CouldntParseDataOauth
}

class OAuthWrapper: OAuthWrapping {
    private let oAuth: OAuth1Swift

    init(
        consumerKey: String,
        consumerSecret: String,
        requestToken: String,
        authoriseUrl: String,
        accessToken: String
    ) {
        self.oAuth = OAuth1Swift(
            consumerKey: consumerKey,
            consumerSecret: consumerSecret,
            requestTokenUrl: requestToken,
            authorizeUrl: authoriseUrl,
            accessTokenUrl: accessToken
        )
    }

    func authorize(callbackURL: String) async -> Result<AuthResponse, Error> {
        await withCheckedContinuation({ continuation in
            let handle = oAuth.authorize(
                withCallbackURL: callbackURL
            ) { [weak self] result in
                guard let self = self else { return }
                continuation.resume(returning: self.didRecieveCallback(result))
            }
        })

    }

    class func handle(url: URL) {
        OAuthSwift.handle(url: url)
    }
}

private extension OAuthWrapper {
    func didRecieveCallback(
        _ result: Result<OAuthSwift.TokenSuccess, OAuthSwiftError>
    ) -> Result<AuthResponse, Error> {
        switch result {
        case .success(let (credential, _, params)):
            guard let user = parseUser(params: params),
                  let creds = parseCredentials(credential) else {
                return .failure(OAuthWrappingError.CouldntParseDataOauth)
            }
            let response = AuthResponse(user: user, credentials: creds)
            return .success(response)
        case .failure(let error):
            return .failure(error)
        }
    }

    func parseUser(params: OAuthSwift.Parameters) -> AuthUser? {
        if let name = params["screen_name"] as? String,
           let token = params["oauth_token"] as? String,
           let userId = params["user_id"] as? String,
           let tokenSecret = params["oauth_token_secret"] as? String {
            return AuthUser(screenName: name, oauthToken: token, userId: userId, oauthTokenSecret: tokenSecret)
        }
        return nil
    }

    func parseCredentials(_ credentials: OAuthSwiftCredential) -> AuthCredentials? {
        return AuthCredentials(
            key: credentials.consumerKey,
            secret: credentials.consumerSecret,
            token: credentials.oauthToken,
            refreshToken: credentials.oauthRefreshToken,
            tokenSecret: credentials.oauthTokenSecret,
            tokenExpiresAt: credentials.oauthTokenExpiresAt,
            verifier: credentials.oauthVerifier
        )
    }
}

// Step 2: Perform OAuth authentication
//oauthswift.authorize(withCallbackURL: URL(string: "https://google.com")!) { result in
//    switch result {
//    case .success(let (credential, _, _)):
//        // Step 3: Use the obtained credential to make authenticated requests
//        let url = "https://api.twitter.com/1.1/account/verify_credentials.json"
//        oauthswift.client.get(url, parameters: [:]) { result in
//            switch result {
//            case .success(let response):
//                if let dataString = response.string {
//                    print(dataString)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    case .failure(let error):
//        print(error.localizedDescription)
//    }
//}
