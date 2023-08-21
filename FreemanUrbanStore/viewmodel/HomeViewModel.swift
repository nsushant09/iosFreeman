//
//  HomeViewModel.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/21/23.
//

import Foundation

class HomeViewModel : ObservableObject{
    private let categoryRepo : CategoryRepo = CategoryRepoImpl()
    @Published var categories : [Category] = [Category]()
    
    func fetchCategories(){
        if(!categories.isEmpty) {return}
        
        categories = categoryRepo.getAllCategories()
    }
}
