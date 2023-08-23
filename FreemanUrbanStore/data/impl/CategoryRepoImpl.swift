//
//  CategoryRepoImpl.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/21/23.
//

import Foundation

class CategoryRepoImpl : CategoryRepo{
    
    static private var categories = [Category]()
    
    func getCategories() async -> [Category]?{
        
        if(!CategoryRepoImpl.categories.isEmpty){
            return CategoryRepoImpl.categories
        }
        
        let result = await HTTPRequestExecutor<Category, [Category]>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/category/all")
            .setHttpMethod(HTTPMethods.GET)
            .build()
            .executeAsync()
        
        if let categoryResponse = ResultManager.extractSuccessValue(from: result){
            CategoryRepoImpl.categories = categoryResponse
            return CategoryRepoImpl.categories
        }else {
            return nil
        }
    }
}
