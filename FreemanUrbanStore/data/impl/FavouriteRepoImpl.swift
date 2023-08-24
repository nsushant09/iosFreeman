//
//  FavouriteRepoImpl.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/23/23.
//

import Foundation

class FavouriteRepoImpl : FavouriteRepo{
    func addItemToFavourite(productId: Int, userId: Int) async -> ([Product]?, String) {
        let result = await HTTPRequestExecutor<Product, [Product]>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/favourite/add")
            .setHttpMethod(HTTPMethods.POST)
            .setRequestParams([
                "product_id" : String(productId),
                "user_id" : String(userId)
            ])
            .build()
            .executeAsync()
        
        return ResultManager.returnData(result: result)
    }
    
    func removeItemFromFavourite(productId: Int, userId: Int) async -> ([Product]?, String) {
        let result = await HTTPRequestExecutor<Product, [Product]>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/favourite/remove")
            .setHttpMethod(HTTPMethods.POST)
            .setRequestParams([
                "product_id" : String(productId),
                "user_id" : String(userId)
            ])
            .build()
            .executeAsync()
        
        return ResultManager.returnData(result: result)
    }
    
    func getAllProductFromFavourite(userId: Int) async -> ([Product]?, String) {
        let result = await HTTPRequestExecutor<Product, [Product]>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/favourite/favourite_products")
            .setHttpMethod(HTTPMethods.GET)
            .setRequestParams([
                "user_id" : String(userId)
            ])
            .build()
            .executeAsync()
        
        return ResultManager.returnData(result: result)
    }
    
    
}
