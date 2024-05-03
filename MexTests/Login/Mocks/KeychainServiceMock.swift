//
//  KeychainServiceMock.swift
//  MexTests
//
//  Created by islam metwally on 03.05.24.
//

import Foundation
@testable import Mex

enum KeychainServiceMockError: Error {
    case KeychainServiceMockFailure
}

final class KeychainServiceMock: KeychainServicing {
    var shouldSucceed = true
    func saveToKeychain(service: String, key: String, value: String) -> Result<(), Error> {
        if shouldSucceed {
            return .success(())
        }
        return .failure(KeychainServiceMockError.KeychainServiceMockFailure)
    }
}
