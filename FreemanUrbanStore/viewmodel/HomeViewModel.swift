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
    
    func fetchCategories(){
        if(!categories.isEmpty) {return}
        
        categoryRepo.getCategories{categories, error in
            if(categories == nil){return}
            DispatchQueue.main.async {
                self.categories = categories!
            }
        }
    }
    
    func fetchCategoriesAsync() async{
        if(!categories.isEmpty) {return}
        
        guard let categories = await categoryRepo.getCategories() else {return}
        DispatchQueue.main.async {
            self.categories = categories
        }
        
    }
}
