//
//  MainViewModel.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/22/23.
//

import Foundation

class MainViewModel : ObservableObject{
    @Published var navigateToLogin = false
    
    init(){
        if let userData = UserDefaultsManager<User>.getData(forKey: Constants.AS_LOGGED_IN_USER){
            ApplicationCache.loggedInUser = userData
        }else{
            UserDefaults().removeObject(forKey: Constants.AS_IS_LOGGED_IN)
            UserDefaults().removeObject(forKey: Constants.AS_LOGGED_IN_USER)
            navigateToLogin = true
        }
    }
    
}

