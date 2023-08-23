//
//  CartRepoImpl.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/23/23.
//

import Foundation

class CartRepoImpl : CartRepo{
    func addItemToCart(productId: Int, userId: Int) async -> ([Product]?, String) {
        let result = await HTTPRequestExecutor<Product, [Product]>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/cart/add")
            .setHttpMethod(HTTPMethods.POST)
            .setRequestParams([
                "product_id" : String(productId),
                "user_id" : String(userId)
            ])
            .build()
            .executeAsync()
        
        return ResultManager.returnData(result: result)
    }
    
    func removeItemFromCart(productId: Int, userId: Int) async -> ([Product]?, String) {
        let result = await HTTPRequestExecutor<Product, [Product]>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/cart/remove")
            .setHttpMethod(HTTPMethods.POST)
            .setRequestParams([
                "product_id" : String(productId),
                "user_id" : String(userId)
            ])
            .build()
            .executeAsync()
        
        return ResultManager.returnData(result: result)
    }
    
    func getAllProductFromCart(userId: Int) async -> ([Product]?, String) {
        let result = await HTTPRequestExecutor<Product, [Product]>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/cart/cart_products")
            .setHttpMethod(HTTPMethods.GET)
            .setRequestParams([
                "user_id" : String(userId)
            ])
            .build()
            .executeAsync()
        
        return ResultManager.returnData(result: result)
    }
    
    
}
