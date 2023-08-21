//
//  UserValidator.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/16/23.
//

import Foundation
import SwiftUI

struct UserValidator : Validator{
    let user : User
    
    func validate() -> Bool {
        if(!isValidUsername()) {return false}
        return true
    }
    
    
    func isValidUsername() -> Bool{
        if(user.name.count < 2) {return false}
        if(user.name.count > 50) {return false}
        if(doesContainSpecialCharacter(string: user.name)) {return false}
        return true
    }
    
    func doesContainSpecialCharacter(string : String) -> Bool{
        let pattern = "[^a-zA-Z]"
        if let regex = try? NSRegularExpression(pattern: pattern) {
            let range = NSRange(location: 0, length: string.utf16.count)
            return regex.firstMatch(in: string, options: [], range: range) == nil
        }
        return false
    }
}
