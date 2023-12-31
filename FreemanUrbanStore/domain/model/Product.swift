//
//  Product.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import Foundation

struct Product : Identifiable, Codable, Hashable{
    var id : Int
    var name : String
    var description : String
    var imagePath : String
    var price : Double
    var stock : Int
    var category : Category?
    var discountedPrice : Double?
}
