//
//  CacheLoginModelService.swift
//  Mex
//
//  Created by islam metwally on 02.05.24.
//

import Foundation

enum CachedLoginModelServiceErrors: Error {
    case missingUserData
    case noBundleId
    case couldntSaveData
}

protocol CachedLoginModelServicing {
    func cache(loginModel: LoginDomainModeling) -> Result<(), Error>
    func readCachedLoginModel() -> Result<LoginDomainModeling, Error>
}

struct CachedLoginModelService: CachedLoginModelServicing {
    private let keychainService: KeychainServicing

    init(keychainService: KeychainServicing) {
        self.keychainService = keychainService
    }

    func cache(loginModel: LoginDomainModeling) -> Result<(), Error> {
        guard let bundleId = Bundle.main.bundleIdentifier else {
            return Result.failure(CachedLoginModelServiceErrors.noBundleId)
        }
        let key = keychainService.saveToKeychain(
            service: bundleId,
            key: String.consumerKey,
            value: loginModel.key
        )
        switch key {
        case .failure(let err):
            return .failure(err)
        case .success(()):
            break
        }
        let secret = keychainService.saveToKeychain(
            service: bundleId,
            key: String.consumerSecret,
            value: loginModel.secret
        )
        switch secret {
        case .failure(let err):
            return .failure(err)
        case .success(()):
            break
        }
        let token = keychainService.saveToKeychain(
            service: bundleId,
            key: String.oauthToken,
            value: loginModel.oauthToken
        )
        switch token {
        case .failure(let err):
            return .failure(err)
        case .success(()):
            break
        }
        let tokenSecret = keychainService.saveToKeychain(
            service: bundleId,
            key: String.oauthTokenSecret,
            value: loginModel.oauthTokenSecret
        )
        switch tokenSecret {
        case .failure(let err):
            return .failure(err)
        case .success(()):
            break
        }
        let refreshToken = keychainService.saveToKeychain(
            service: bundleId,
            key: String.refreshToken,
            value: loginModel.refreshToken
        )
        switch refreshToken {
        case .failure(let err):
            return .failure(err)
        case .success(()):
            break
        }
        let screenName = keychainService.saveToKeychain(
            service: bundleId,
            key: String.screenName,
            value: loginModel.screenName
        )
        switch screenName {
        case .failure(let err):
            return .failure(err)
        case .success(()):
            break
        }
        let userId = keychainService.saveToKeychain(
            service: bundleId,
            key: String.userId,
            value: loginModel.userId
        )
        switch userId {
        case .failure(let err):
            return .failure(err)
        case .success(()):
            break
        }
        let verifier = keychainService.saveToKeychain(
            service: bundleId,
            key: String.verifier,
            value: loginModel.verifier
        )
        switch verifier {
        case .failure(let err):
            return .failure(err)
        case .success(()):
            break
        }
        return .success(())
    }

    func readCachedLoginModel() -> Result<LoginDomainModeling, Error> {
        guard let bundleId = Bundle.main.bundleIdentifier,
              let key = keychainService.loadFromKeychain(service: bundleId, key: String.consumerKey),
              let secret = keychainService.loadFromKeychain(service: bundleId, key: String.consumerSecret),
              let token = keychainService.loadFromKeychain(service: bundleId, key: String.oauthToken),
              let tokenSecret = keychainService.loadFromKeychain(service: bundleId, key: String.oauthTokenSecret),
              let refreshToken = keychainService.loadFromKeychain(service: bundleId, key: String.refreshToken),
              let screenName = keychainService.loadFromKeychain(service: bundleId, key: String.screenName),
              let userId = keychainService.loadFromKeychain(service: bundleId, key: String.refreshToken),
              let verifier = keychainService.loadFromKeychain(service: bundleId, key: String.verifier) else {
            return .failure(CachedLoginModelServiceErrors.missingUserData)
        }
        let loginDM = LoginDomainModel(
            screenName: screenName,
            oauthToken: token,
            userId: userId,
            oauthTokenSecret: tokenSecret,
            key: key,
            secret: secret,
            refreshToken: refreshToken,
            tokenExpiresAt: nil,
            verifier: verifier
        )
        return .success(loginDM)
    }
}

private extension String {
    static let consumerKey = "TWITTER_CONSUMER_KEY"
    static let consumerSecret = "TWITTER_CONSUMER_SECRET"
    static let oauthToken = "OAUTH_TOKEN"
    static let oauthTokenSecret = "OAUTH_TOKEN_SECRET"
    static let refreshToken = "OAUTH_REFRESH_TOKEN"
    static let userId = "USER_ID"
    static let screenName = "SCREEN_NAME"
    static let verifier = "OAUTH_VERIFIER"
}
