//
//  ProductRepoImpl.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/23/23.
//

import Foundation

class ProductRepoImpl : ProductRepo{
    func insertProduct(userId : Int, categoryId : Int, product: Product) async -> (Product?, String) {
        let result = await HTTPRequestExecutor<Product, Product>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/product/")
            .setHttpMethod(HTTPMethods.POST)
            .setRequestBody(product)
            .setRequestParams([
                "user_id" : String(userId),
                "category_id" : String(categoryId)
            ])
            .build()
            .executeAsync()
        
        return ResultManager.returnData(result: result)
    }
    
    func updateProduct(product: Product) async -> (Product?, String) {
        let result = await HTTPRequestExecutor<Product, Product>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/product/")
            .setHttpMethod(HTTPMethods.PUT)
            .setRequestBody(product)
            .build()
            .executeAsync()
        
        return ResultManager.returnData(result: result)
    }
    
    func productById(id: Int) async -> (Product?, String) {
        let result = await HTTPRequestExecutor<Product, Product>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/product/by_product_id")
            .setHttpMethod(HTTPMethods.GET)
            .setRequestParams([
                "product_id" : String(id)
            ])
            .build()
            .executeAsync()
        
        return ResultManager.returnData(result: result)
    }
    
    func productByCategory(id: Int) async -> ([Product]?, String) {
        let result = await HTTPRequestExecutor<Product, [Product]>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/product/by_category_id")
            .setHttpMethod(HTTPMethods.GET)
            .setRequestParams([
                "category_id" : String(id)
            ])
            .build()
            .executeAsync()
        
        return ResultManager.returnData(result: result)
    }
    
    func productByUser(id: Int) async -> ([Product]?, String) {
        let result = await HTTPRequestExecutor<Product, [Product]>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/product/by_user_id")
            .setHttpMethod(HTTPMethods.GET)
            .setRequestParams([
                "user_id" : String(id)
            ])
            .build()
            .executeAsync()
        
        return ResultManager.returnData(result: result)
    }
    
    func allProducts() async -> ([Product]?, String) {
        let result = await HTTPRequestExecutor<Product, [Product]>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/product/all")
            .setHttpMethod(HTTPMethods.GET)
            .build()
            .executeAsync()
        
        return ResultManager.returnData(result: result)
    }
    
    func productBySearchValue(value: String) async -> ([Product]?, String) {
        let result = await HTTPRequestExecutor<Product, [Product]>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/product/search")
            .setHttpMethod(HTTPMethods.GET)
            .setRequestParams([
                "value" : value
            ])
            .build()
            .executeAsync()
        
        return ResultManager.returnData(result: result)
    }
}
