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

    var body: some Scene {
        WindowGroup {
            let loginViewVM = LoginViewVMFactory().loginViewVM()
            LoginView(loginViewVM: loginViewVM)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onOpenURL { url in
                    onOpenURL(url)
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
