//
//  SearchViewModel.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/25/23.
//

import Foundation

class SearchViewModel : ObservableObject{
    
    let productRepo : ProductRepo = ProductRepoImpl()
    
    @Published var products = [Product]()
    
    func fetchSearchProducts(value : String) async {
        let (data, _) = await productRepo.productBySearchValue(value: value)
        guard let data = data else {return}
        DispatchQueue.main.async {[weak self] in
            self?.products = data
        }
    }
}
