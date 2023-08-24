//
//  HomeViewModel.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/21/23.
//

import Foundation

class HomeViewModel : ObservableObject{
    
    private let productsRepo : ProductRepo = ProductRepoImpl()
    private let categoryRepo  : CategoryRepo = CategoryRepoImpl()
    
    @Published var products : [Product] = [Product]()
    @Published var categories : [Category] = [Category]()
    
    func fetchCategories() async{
        if(!categories.isEmpty) {return}
        
        if let categories = await categoryRepo.getCategories(){
            DispatchQueue.main.async {[weak self] in
                self?.categories = categories
            }
        }
    }
    
    func fetchProducts() async{
        if(!products.isEmpty) {return}
        let (products, _) = await productsRepo.allProducts()
        if let products = products {
            DispatchQueue.main.async {[weak self] in
                self?.products = products
            }
        }
    }
    
}
