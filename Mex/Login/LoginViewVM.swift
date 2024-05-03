//
//  LoginViewVM.swift
//  Mex
//
//  Created by islam metwally on 01.05.24.
//

import SwiftUI

final class LoginViewVM: ObservableObject {
    private let loginService: LoginServicing
    private let cacheLoginModelService: CachedLoginModelServicing
    @Published private(set) var isLoading: Bool = false

    init(loginService: LoginServicing, cacheLoginModelService: CachedLoginModelServicing) {
        self.loginService = loginService
        self.cacheLoginModelService = cacheLoginModelService
    }

    func onDidTouchDownCTA(app: MexAppViewModelLoginListener) async {
        switchLoadingFlag()
        let result = await loginService.login()
        switch result {
        case .success(let loginDM):
            let presistResult = presistAuthData(loginDM: loginDM)
            if case .success(_) = presistResult {
                app.didSuccessfullyLogin(loginDM: loginDM)
            }
        case .failure(let error):
            print(error)
        }
        switchLoadingFlag()
    }
}

private extension LoginViewVM {
    func presistAuthData(loginDM: LoginDomainModeling) -> Result<(), Error> {
        let cacheResult = cacheLoginModelService.cache(loginModel: loginDM)
        switch cacheResult {
        case .failure(let err):
            return .failure(err)
        case .success(_):
            return .success(())
        }
    }

    func switchLoadingFlag() {
        Task {
            await MainActor.run {
                isLoading = !isLoading
            }
        }
    }
}
