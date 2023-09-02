//
//  GETTaskPerformer.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/22/23.
//

import Foundation

struct GETTaskPerformer<ResponseType : Codable> : PerformableTask{
    func performTaskAsync() async throws -> Result<ResponseType>{
        if(request.url == nil){
            return .failure("Invalid URL")
        }
        
        let (data, response) = try await URLSession.shared.data(from: request.url!)
        return try handleResponse(data: data, response: response)
    }
    
    let request : URLRequest
}
