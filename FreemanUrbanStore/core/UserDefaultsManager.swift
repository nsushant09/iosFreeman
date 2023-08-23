//
//  UserDefaultsManager.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/22/23.
//

import Foundation

struct UserDefaultsManager<T : Codable>{
    static func storeData(data : T, forKey : String) -> Bool{
        do{
            let userJSON = try JSONEncoder().encode(data)
            UserDefaults.standard.setValue(userJSON, forKey: forKey)
            return true
        }catch{
            return false
        }
    }
    
    static func getData(forKey: String) -> T?{
        do{
            guard let jsonData = UserDefaults.standard.data(forKey: Constants.AS_LOGGED_IN_USER) else {return nil}
            let data = try JSONDecoder().decode(T.self, from: jsonData)
            return data
        }catch{
            return nil
        }
    }
}
