//
//  MexAppViewModel.swift
//  Mex
//
//  Created by islam metwally on 02.05.24.
//

import Foundation

protocol MexAppViewModelLoginListener {
    func didSuccessfullyLogin(loginDM: LoginDomainModeling)
}

final class MexAppViewModel: ObservableObject {
    private let cacheLoginModelService: CachedLoginModelServicing
    @Published private(set) var loginDM: LoginDomainModeling?

    init(cacheLoginModelService: CachedLoginModelServicing) {
        self.cacheLoginModelService = cacheLoginModelService
        self.loginDM = cachedUser
    }
}

extension MexAppViewModel: MexAppViewModelLoginListener {
    func didSuccessfullyLogin(loginDM: LoginDomainModeling) {
        Task {
            await MainActor.run {
                self.loginDM = loginDM
            }
        }
    }
}

private extension MexAppViewModel {
    var cachedUser: LoginDomainModeling? {
        let cachedLoginModelResult = cacheLoginModelService.readCachedLoginModel()
        if case .success(let loginDM) = cachedLoginModelResult {
            return loginDM
        }
        return nil
    }
}
