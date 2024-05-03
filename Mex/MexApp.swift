//
//  MexApp.swift
//  Mex
//
//  Created by islam metwally on 30.04.24.
//

import SwiftUI

@main
struct MexApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var mexAppVM = MexAppViewModel(
        cacheLoginModelService: CachedLoginModelService(
            keychainService: KeychainService()
        )
    )

    var body: some Scene {
        WindowGroup {
            if mexAppVM.loginDM == nil {
                loginView
            } else {
                tabbarView
            }
        }
    }

    var loginView: some View {
        let loginViewVM = LoginViewVMFactory().loginViewVM()
        return LoginView(loginViewVM: loginViewVM)
            .environmentObject(mexAppVM)
            .onOpenURL { url in
                onOpenURL(url)
            }
    }

    var tabbarView: some View {
        TabView {
            Text("Tweets")
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("Tab 1")
                }
        }
    }
}

private extension MexApp {
    func onOpenURL(_ url: URL) {
        if url.host == "oauth-callback" {
            OAuthWrapper.handle(url: url)
        }
    }
}
