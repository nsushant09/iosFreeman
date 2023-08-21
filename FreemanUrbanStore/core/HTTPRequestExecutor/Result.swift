//
//  Result.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/21/23.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Any)
}
