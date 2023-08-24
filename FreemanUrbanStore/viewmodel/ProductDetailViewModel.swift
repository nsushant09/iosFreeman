//
//  ProductDetailViewModel.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/23/23.
//

import Foundation

class ProductDetailViewModel : ObservableObject{
    
    @Published var product : Product
    @Published var reviews = [Review]()
    
    @Published var isAddedToCart = false
    @Published var isAddedToFavourites = false
    
    @Published var averageReviewRating : Double = 0;
    
    let cartRepo : CartRepo = CartRepoImpl()
    let reviewRepo : ReviewRepo = ReviewRepoImpl()
    let favouritesRepo : FavouriteRepo = FavouriteRepoImpl()
    
    init(mProduct : Product){
        product = mProduct
    }
    
    func fetchReviews() async {
        let (data, _) = await reviewRepo.getReviewsForProduct(productId: product.id)
        if let data = data {
            DispatchQueue.main.async {[weak self] in
                self?.reviews = data
                self?.getAverageReviewRating()
            }
        }
    }
    
    func fetchFavourite() async {
        guard let user = ApplicationCache.loggedInUser else {return}
        let (data, _) = await favouritesRepo.getAllProductFromFavourite(userId: user.id)
        if let data = data {
            DispatchQueue.main.async {[weak self] in
                guard let product = self?.product else {return}
                self?.isAddedToFavourites = data.contains(product)
            }
        }
    }
    
    func fetchCart() async {
        guard let user = ApplicationCache.loggedInUser else {return}
        let (data, _) = await cartRepo.getAllProductFromCart(userId: user.id)
        if let data = data {
            DispatchQueue.main.async {[weak self] in
                guard let product = self?.product else {return}
                self?.isAddedToCart = data.contains(product)
            }
        }
    }
    
    func addToCart() async {
        DispatchQueue.main.async {[weak self] in
            self?.isAddedToCart = true
        }
        
        guard let user = ApplicationCache.loggedInUser else {return}
        let (_ , _) = await cartRepo.addItemToCart(productId: product.id, userId: user.id)
    }
    
    func addToFavourites() async {
        DispatchQueue.main.async {[weak self] in
            self?.isAddedToFavourites = true
        }
        
        guard let user = ApplicationCache.loggedInUser else {return}
        let (_ , _) = await favouritesRepo.addItemToFavourite(productId: product.id, userId: user.id)
    }
    
    func removeFromCart() async {
        DispatchQueue.main.async {[weak self] in
            self?.isAddedToCart = false
        }
        
        guard let user = ApplicationCache.loggedInUser else {return}
        let (_ , _) = await cartRepo.removeItemFromCart(productId: product.id, userId: user.id)
    }
    
    func removeFromFavourites() async {
        DispatchQueue.main.async {[weak self] in
            self?.isAddedToFavourites = false
        }
        
        guard let user = ApplicationCache.loggedInUser else {return}
        let (_ , _) = await favouritesRepo.removeItemFromFavourite(productId: product.id, userId: user.id)
    }
    
    func getAverageReviewRating(){
        var totalRating : Double = 0;
        reviews.forEach({review in
            totalRating = totalRating + Double(review.rating)
        })
        
        averageReviewRating = totalRating / Double(reviews.count)
    }
    
}
