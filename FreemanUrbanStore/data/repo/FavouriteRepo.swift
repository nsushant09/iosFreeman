//
//  FavouriteRepo.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/23/23.
//

import Foundation

protocol FavouriteRepo{
    func addItemToFavourite(productId : Int, userId : Int) async -> ([Product]?, String)
    
    func removeItemFromFavourite(productId : Int, userId : Int) async -> ([Product]?, String)
    
    func getAllProductFromFavourite(userId : Int) async -> ([Product]?, String)
}
