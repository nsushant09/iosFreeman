//
//  ApplicationCache.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/23/23.
//

import Foundation

class ApplicationCache{
    static var loggedInUser : User?
    
    static func logOut() -> Bool {
        UserDefaults().removeObject(forKey: Constants.AS_IS_LOGGED_IN)
        UserDefaults().removeObject(forKey: Constants.AS_LOGGED_IN_USER)
        return true
    }
}
