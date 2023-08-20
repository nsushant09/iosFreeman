//
//  Review.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import Foundation

struct Review : Identifiable, Codable, Hashable{
    var id : Int
    var description : String
    var rating : Int
    var date : String
    var username : String
    
}
