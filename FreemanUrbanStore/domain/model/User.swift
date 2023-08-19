//
//  User.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/16/23.
//

import Foundation

struct User :Identifiable, Codable, Hashable{
    var id : Int
    var name : String
    var email : String
    var gender : String
    var password : String
    var phoneNumber : String
    var dateOfBirth : String
    var role : String
}
