//
//  CategoryRepoImpl.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/21/23.
//

import Foundation

struct CategoryRepoImpl : CategoryRepo{
    
    func getCategories(completion : @escaping([Category]? , Error?) -> Void){
        HTTPRequestExecutor<Category, [Category]>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/category/all")
            .setHttpMethod(HTTPMethods.GET)
            .build()
            .execute(completion: completion)
    }
    
    func getCategories() async -> [Category]?{
            return await HTTPRequestExecutor<Category, [Category]>
                .Builder()
                .setRequestUrl(Constants.BASE_URL + "/category/all")
                .setHttpMethod(HTTPMethods.GET)
                .build()
                .executeAsync()
    }
    
}
