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
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
