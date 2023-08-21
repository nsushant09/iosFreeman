//
//  CategoryRepo.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/21/23.
//

import Foundation

protocol CategoryRepo {
    func getCategories(completion : @escaping([Category]? , Error?) -> Void)
}
