//
//  MexAppViewModelLoginListenerMock.swift
//  MexTests
//
//  Created by islam metwally on 03.05.24.
//

import Foundation
@testable import Mex

final class MexAppViewModelLoginListenerMock: MexAppViewModelLoginListener {
    var didSuccessfullyLogin = false
    func didSuccessfullyLogin(loginDM: LoginDomainModeling) {
        didSuccessfullyLogin = true
    }
}
