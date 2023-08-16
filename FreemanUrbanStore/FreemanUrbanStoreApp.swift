//
//  FreemanUrbanStoreApp.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/15/23.
//

import SwiftUI

@main
struct FreemanUrbanStoreApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
