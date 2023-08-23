//
//  ProductRepo.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/23/23.
//

import Foundation

protocol ProductRepo{
    func insertProduct(userId : Int, categoryId : Int, product : Product) async -> (Product?, String)
    func updateProduct(product : Product) async -> (Product?, String)
    func productById(id : Int) async -> (Product?, String)
    func productByCategory(id : Int) async -> ([Product]?, String)
    func productByUser(id : Int) async -> ([Product]?, String)
    func allProducts() async -> ([Product]? , String)
}
