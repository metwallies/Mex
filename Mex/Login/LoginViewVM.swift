//
//  LoginViewVM.swift
//  Mex
//
//  Created by islam metwally on 01.05.24.
//

import SwiftUI

final class LoginViewVM: ObservableObject {
    private let loginService: LoginService

    init(loginService: LoginService) {
        self.loginService = loginService
    }

    func onAppear() {
    }
}
