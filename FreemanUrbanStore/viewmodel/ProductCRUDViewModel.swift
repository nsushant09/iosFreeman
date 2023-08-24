//
//  ProductCRUDViewModel.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/22/23.
//

import Foundation
import SwiftUI
import PhotosUI

class ProductCrudViewModel : ObservableObject{
    
    private let categoryRepo  = CategoryRepoImpl()
    private let productRepo = ProductRepoImpl()
    
    @Published var name = ""
    @Published var description = ""
    @Published var price = ""
    @Published var stock = ""
    @Published var discountedPrice = ""
    
    @Published var userId = ""
    @Published var category = ""
    
    @Published var categories = [Category]()
    
    @Published var errorMessage = ""
    @Published var isProductInserted = false;
    
    func insertProduct() async {
        guard let categoryId = getCategoryIdFromName(name: category) else {return}
        guard let userId = ApplicationCache.loggedInUser?.id else {return}
        let product = Product(id: -1, name: name, description: description, imagePath: "", price: Double(price) ?? 0, stock: Int(stock) ?? 0)
        
        let (data, error) = await productRepo.insertProduct(userId: userId, categoryId: categoryId, product: product)
        
        if let _ = data {
            DispatchQueue.main.async {[weak self] in
                self?.isProductInserted = true
            }
        }else {
            DispatchQueue.main.async {[weak self] in
                self?.errorMessage = error
            }
        }
    }
    
    func getCategoryIdFromName(name : String) -> Int?{
        return categories.first(where: {category in
            category.name == name
        })?.id
    }
    
    func fetchCategoriesAsync() async{
        if(!categories.isEmpty) {return}
        
        if let categories = await categoryRepo.getCategories(){
            DispatchQueue.main.async {[weak self] in
                self?.categories = categories
                self?.category = categories[0].name
            }
        }
    }
}
