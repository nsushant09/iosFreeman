//
//  TaskPerformerFactory.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/22/23.
//

import Foundation

struct TaskPerformerFactory<ResponseType : Codable> {
    static func getTaskPerformer(httpMethod : HTTPMethods,request : URLRequest) -> any PerformableTask<ResponseType>{
        switch httpMethod {
        case .GET :
            return GETTaskPerformer<ResponseType>(request: request)
        case .PATCH, .POST, .PUT :
            return POSTTaskPerformer<ResponseType>(request: request)
        default :
            return POSTTaskPerformer<ResponseType>(request: request)
        }
    }
}
