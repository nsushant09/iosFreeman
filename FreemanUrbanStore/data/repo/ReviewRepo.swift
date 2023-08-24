//
//  ReviewRepo.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/23/23.
//

import Foundation

protocol ReviewRepo{
    func insertReview(productId : Int, userId : Int, review : Review) async -> (Review?, String)
    func getReviewsForProduct(productId : Int) async -> ([Review]?, String)
}
