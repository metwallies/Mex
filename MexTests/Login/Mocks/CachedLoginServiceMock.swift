//
//  CachedLoginServiceMock.swift
//  MexTests
//
//  Created by islam metwally on 03.05.24.
//

import Foundation
@testable import Mex

enum CachedLoginServiceMockError: Error {
    case cachedLoginServiceMockFailure
}

final class CachedLoginServiceMock: CachedLoginModelServicing {
    var shouldSucceed: Bool = true
    init(shouldSucceed: Bool = true) {
        self.shouldSucceed = shouldSucceed
    }

    func cache(loginModel: Mex.LoginDomainModeling) -> Result<(), Error> {
        if shouldSucceed {
            return .success(())
        } else {
            return .failure(CachedLoginServiceMockError.cachedLoginServiceMockFailure)
        }
    }

    func readCachedLoginModel() -> Result<Mex.LoginDomainModeling, Error> {
        if shouldSucceed {
            return .success(LoginDomainModel.mock)
        } else {
            return .failure(CachedLoginServiceMockError.cachedLoginServiceMockFailure)
        }
    }
}
