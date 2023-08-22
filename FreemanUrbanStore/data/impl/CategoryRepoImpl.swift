//
//  CategoryRepoImpl.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/21/23.
//

import Foundation

struct CategoryRepoImpl : CategoryRepo{
    
    func getCategories() async -> [Category]?{
        let result = await HTTPRequestExecutor<Category, [Category]>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/category/all")
            .setHttpMethod(HTTPMethods.GET)
            .build()
            .executeAsync()
        
        switch result{
        case .success(let data):
            return data
        case .failure(_):
            return nil
        }
    }
    
}
