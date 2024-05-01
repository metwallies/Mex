//
//  TwitterToken.swift
//  Mex
//
//  Created by islam metwally on 01.05.24.
//

import Foundation

enum TwitterTokenError: Int, Error {
    case plistNotFound
    case keyOrSecretNotFound
}

struct TwitterToken {
    let key: String
    let secret: String

    static var shared: TwitterToken? {
        let result = keyAndSecret
        switch result {
        case .success(let (key, secret)):
            return TwitterToken(key: key, secret: secret)
        case .failure:
            //TODO: Log error
            return nil
        }
    }

    private init(key: String, secret: String) {
        self.key = key
        self.secret = secret
    }

    private static var keyAndSecret: Result<(String, String), Error> {
        guard let plistPath = Bundle.main.path(forResource: "TwitterAuth", ofType: "plist") else {
            return .failure(TwitterTokenError.plistNotFound)
        }
        do {
            if let plistData = FileManager.default.contents(atPath: plistPath) {
                // Parse the plist data
                var format = PropertyListSerialization.PropertyListFormat.xml
                let plistDict = try PropertyListSerialization.propertyList(from: plistData, options: .mutableContainersAndLeaves, format: &format) as! [String: Any]

                if let key = plistDict["TWITTER_CONSUMER_KEY"] as? String,
                   let secret = plistDict["TWITTER_CONSUMER_SECRET"] as? String {
                    return .success((key, secret))
                } else {
                    return .failure(TwitterTokenError.keyOrSecretNotFound)
                }
            } else {
                return .failure(TwitterTokenError.plistNotFound)
            }
        } catch {
            return .failure(error)
        }
    }
}
