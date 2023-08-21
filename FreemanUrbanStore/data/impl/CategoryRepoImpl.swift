//
//  CategoryRepoImpl.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/21/23.
//

import Foundation

struct CategoryRepoImpl : CategoryRepo{
    
    func getAllCategories() -> [Category] {
        
        var response : [Category] = [Category]()
        
        HTTPRequestExecutor<Category, [Category]>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/category/all")
            .setHttpMethod(HTTPMethods.GET)
            .build()
            .execute(completion: {categories, error in
                guard let categories = categories else {
                    return
                }
                response = categories
            })
        return response;
    }
}
