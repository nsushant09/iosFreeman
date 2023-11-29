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
            else if(UserDefaults.standard.bool(forKey: Constants.AS_IS_LOGGED_IN)){
                MainView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }else{
                LoginView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
