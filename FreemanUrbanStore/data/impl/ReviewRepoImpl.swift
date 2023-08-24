//
//  ReviewRepoImpl.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/23/23.
//

import Foundation

class ReviewRepoImpl : ReviewRepo{
    func insertReview(productId: Int, userId : Int, review : Review) async -> (Review?, String) {
        let result = await HTTPRequestExecutor<Review, Review>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/review/")
            .setHttpMethod(HTTPMethods.POST)
            .setRequestBody(review)
            .setRequestParams([
                "product_id" : String(productId),
                "user_id" : String(userId)
            ])
            .build()
            .executeAsync()
        
        return ResultManager.returnData(result: result)
    }
    
    func getReviewsForProduct(productId: Int) async -> ([Review]?, String) {
        let result = await HTTPRequestExecutor<Review, [Review]>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/review/all_by_product_id")
            .setHttpMethod(HTTPMethods.GET)
            .setRequestParams([
                "product_id" : String(productId)
            ])
            .build()
            .executeAsync()
        
        return ResultManager.returnData(result: result)
    }
    
    
}
