//
//  UserValidator.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/16/23.
//

import Foundation
import SwiftUI

struct UserValidator {
    
    let user: User
    let dateFormatter = DateFormatter()
    
    func validate() -> Bool {
        return isValidUsername() &&
        isValidPassword() &&
        isValidPhoneNumber() &&
        isValidDateOfBirth() &&
        isValidGender()
    }
    
    
    func isValidUsername() -> Bool {
        return user.name.count >= 2 && user.name.count <= 50 && !doesContainSpecialCharacter(string: user.name)
    }
    
    func isValidPassword() -> Bool {
        let passwordPattern = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordPattern).evaluate(with: user.password)
    }
    
    func isValidPhoneNumber() -> Bool {
        let phoneNumberPattern = "^[0-9]{10}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneNumberPattern).evaluate(with: user.phoneNumber)
    }
    
    func isValidDateOfBirth() -> Bool {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let dobString = user.dateOfBirth,
           let dob = dateFormatter.date(from: dobString) {
            return dob < Date()
        }
        return false
    }
    
    func isValidRole() -> Bool {
        let validRoles = ["USER", "ADMIN", "TRADER"]
        guard let userRole = user.role?.lowercased() else {
            return false
        }
        return validRoles.contains(userRole)
    }
    
    func isValidGender() -> Bool {
        let validGenders = ["Male", "Female"]
        guard let userGender = user.gender else{
            return false
        }
        return validGenders.contains(userGender)
    }
    
    
    func isValidEmail() -> Bool {
        let emailPattern = "^[A-Za-z0-9+_.-]+@([A-Za-z0-9.-]+\\.[A-Za-z]{2,})$"
        return NSPredicate(format: "SELF MATCHES %@", emailPattern).evaluate(with: user.email)
    }
    
    func doesContainSpecialCharacter(string: String) -> Bool {
        let pattern = "[^a-zA-Z]"
        if let regex = try? NSRegularExpression(pattern: pattern) {
            let range = NSRange(location: 0, length: string.utf16.count)
            return regex.firstMatch(in: string, options: [], range: range) != nil
        }
        return false
    }
}
