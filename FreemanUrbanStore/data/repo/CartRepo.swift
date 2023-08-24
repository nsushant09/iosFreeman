//
//  CartRepo.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/23/23.
//

import Foundation

protocol CartRepo{
    func addItemToCart(productId : Int, userId : Int) async -> ([Product]?, String)
    
    func removeItemFromCart(productId : Int, userId : Int) async -> ([Product]?, String)
    
    func getAllProductFromCart(userId : Int) async -> ([Product]?, String)
    
    func resolveAmbiguity()
}
