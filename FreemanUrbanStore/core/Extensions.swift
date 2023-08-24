//
//  Extensions.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/21/23.
//

import Foundation

func notNullAsync<T>(_ object: T?, _ closure: (T) async -> Void) async {
    if(object != nil){
        await closure(object!)
    }
}

func notNull<T>(_ object: T?, _ closure: (T) -> Void) {
    if(object != nil){
        closure(object!)
    }
}

extension Double {
    func toString() -> String {
        return String(format: "%.2f", self)
    }
}
