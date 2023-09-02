//
//  POSTTaskPerformer.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/22/23.
//

import Foundation

struct POSTTaskPerformer<ResponseType : Codable> : PerformableTask{
    func performTaskAsync() async throws -> Result<ResponseType>{
        if(request.url == nil){
            return .failure("Invalid URL")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        return try handleResponse(data: data, response: response)
    }
    
    let request : URLRequest
}
