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
    
    @Published var id = -1
    @Published var name = ""
    @Published var description = ""
    @Published var price = ""
    @Published var stock = ""
    @Published var discountedPrice = ""
    @Published var image : UIImage? = nil
    
    @Published var userId = ""
    @Published var category = ""
    @Published var categories = [Category]()
    @Published var errorMessage = ""
    
    @Published var isProductUpdated = false
    @Published var isProductInserted = false;
    
    func insertProduct() async {
        guard let categoryId = getCategoryIdFromName(name: category) else {return}
        guard let user = ApplicationCache.loggedInUser else {return}
        
        guard let imagePath = await insertImage(username : user.name, image: image) else {return}
        
        let product = Product(id: -1, name: self.name, description: self.description, imagePath: imagePath, price: Double(price) ?? 0, stock: Int(stock) ?? 0)
        
        let (data, error) = await productRepo.insertProduct(userId: user.id, categoryId: categoryId, product: product)
        
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
    
    func insertImage(username : String, image: UIImage?) async -> String? {
        guard let image = image else { return nil }

        let multipart = MultipartImageFile()
        let requestBody = multipart.multipartFormDataBody(username, [image])
        let request = multipart.generateRequest(httpBody: requestBody)

        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            if let responseString = String(data: data, encoding: .utf8) {
                print(responseString)
                return responseString
            } else {
                print("Unable to convert data to string.")
                return nil
            }
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
    func updateProduct() async{
        
        guard let imagePath = await insertImage(image: image) else {return}
        if (id == -1) {return}
        
        
        let product = Product(id: id, name: self.name, description: self.description, imagePath: imagePath, price: Double(price) ?? 0, stock: Int(stock) ?? 0)
        
        let (data, error) = await productRepo.updateProduct(product: product)
        
        if let _ = data {
            DispatchQueue.main.async {[weak self] in
                self?.isProductUpdated = true
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

