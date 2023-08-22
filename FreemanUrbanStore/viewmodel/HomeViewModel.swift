//
//  HomeViewModel.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/21/23.
//

import Foundation

class HomeViewModel : ObservableObject{
    private let categoryRepo  = CategoryRepoImpl()
    @Published var categories : [Category] = [Category]()
    
    func fetchCategoriesAsync() async{
        if(!categories.isEmpty) {return}
        
        if let categories = await categoryRepo.getCategories(){
            DispatchQueue.main.async {
                self.categories = categories
            }
        }
    }
}
