//
//  Result.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/21/23.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(String)
}

struct ResultManager{
    static func extractSuccessValue<T>(from result: Result<T>) -> T? {
        switch result {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    static func extractFailureValue<T>(from result: Result<T>) -> String {
        switch result {
        case .success:
            return ""
        case .failure(let error):
            return error
        }
    }
    
}
