//
//  CartViewModel.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/24/23.
//

import Foundation

class CartViewModel : ObservableObject{
    
    let cartRepo: CartRepo = CartRepoImpl()
    @Published var cartProducts = [Product]()
    @Published var subTotalAmount : Double = 0
    @Published var deliveryFee : Double = 100
    @Published var discount : Double = 0
    @Published var checkoutPrice : Double = 0;
    
    func getCartProducts() async {
        guard let user = ApplicationCache.loggedInUser else {return}
        let (data, _) = await cartRepo.getAllProductFromCart(userId: user.id)
        if let data = data {
            DispatchQueue.main.async {[weak self] in
                self?.cartProducts = data
                self?.setPriceDetails()
            }
        }
    }
    
    func removeProductFromCart(productId : Int) async {
        DispatchQueue.main.async {[weak self] in
            if let cartProducts = self?.cartProducts{
                self?.cartProducts = cartProducts.filter({product in
                    return product.id != productId
                })
                self?.setPriceDetails()
            }
        }

        guard let user = ApplicationCache.loggedInUser else {return}
        let (_, _) = await cartRepo.removeItemFromCart(productId: productId, userId: user.id)
    }
    
    func setPriceDetails(){
        setSubtotalAmount()
        setDelivery()
        setDiscount()
    }
    
    func setSubtotalAmount(){
        var sum : Double = 0;
        cartProducts.forEach({product in
            if(product.discountedPrice != nil && product.discountedPrice != 0){
                sum = sum + product.discountedPrice!
            }else{
                sum = sum + product.price
            }
        })
        subTotalAmount = sum;
    }
    
    func setDiscount(){
        var sum : Double = 0;
        cartProducts.forEach({product in
            if(product.discountedPrice != nil && product.discountedPrice != 0){
                sum = sum + product.discountedPrice!
            }
        })
        discount = sum;
    }
    
    func setDelivery(){}
    
    func setCheckoutPrice(){
        checkoutPrice = subTotalAmount + deliveryFee - discount
    }
}
