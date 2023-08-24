//
//  FavouriteViewModel.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/24/23.
//

import Foundation

class FavouriteViewModel : ObservableObject{
    
    private let favouriteRepo: FavouriteRepo = FavouriteRepoImpl()
    @Published var favouriteProducts = [Product]()
//    @Published var similarProducts = [Product]()
    
    func getFavouriteProducts() async {
        guard let user = ApplicationCache.loggedInUser else {return}
        let (data, _) = await favouriteRepo.getAllProductFromFavourite(userId: user.id)
        if let data = data {
            DispatchQueue.main.async {[weak self] in
                self?.favouriteProducts = data
            }
        }
    }
    
    func removeProductFromCart(productId : Int) async {
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
    
}
