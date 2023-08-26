//
//  FavouriteViewModel.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/24/23.
//

import Foundation

class FavouriteViewModel : ObservableObject{
    
    private let productRepo : ProductRepoImpl = ProductRepoImpl()
    private let favouriteRepo: FavouriteRepo = FavouriteRepoImpl()
    
    @Published var favouriteProducts = [Product]()
    @Published var similarProducts = [Product]()
    
    func getFavouriteProducts() async {
        guard let user = ApplicationCache.loggedInUser else {return}
        let (data, _) = await favouriteRepo.getAllProductFromFavourite(userId: user.id)
        if let data = data {
            DispatchQueue.main.async {[weak self] in
                self?.favouriteProducts = data
            }
        }
    }
    
    func removeProductFromFavourite(productId : Int) async {
        DispatchQueue.main.async {[weak self] in
            if let favouriteProducts = self?.favouriteProducts{
                self?.favouriteProducts = favouriteProducts.filter({product in
                    return product.id != productId
                })
            }
        }

        guard let user = ApplicationCache.loggedInUser else {return}
        let (_, _) = await favouriteRepo.removeItemFromFavourite(productId: productId, userId: user.id)
    }
    
    func getSimilarProducts() async {
        var similarProductCategory : Set<Int> = Set(favouriteProducts.compactMap({product in
            product.category?.id
        }))
        
        if(similarProductCategory.isEmpty){
            similarProductCategory = [1, 6]
        }
        
        for categoryId in similarProductCategory{
            await retrieveAndJoinSimilarProducts(categoryId: categoryId)
        }

    }
    
    func retrieveAndJoinSimilarProducts(categoryId : Int) async {
        let(data, _) = await productRepo.productByCategory(id: categoryId)
        if let data = data {
            DispatchQueue.main.async {[weak self] in
                self?.similarProducts.append(contentsOf: data)
            }
        }
    }
    
}
