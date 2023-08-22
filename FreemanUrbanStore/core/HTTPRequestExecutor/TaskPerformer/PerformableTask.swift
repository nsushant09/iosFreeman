//
//  PerformableTask.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/22/23.
//

import Foundation

protocol PerformableTask<ResponseType>{
    associatedtype ResponseType : Codable
    func performTaskAsync() async throws -> Result<ResponseType>
}

extension PerformableTask{
    func handleResponse(data : Data?, response : URLResponse?) throws -> Result<ResponseType>{
        guard
            let data = data,
            let response = response as? HTTPURLResponse else {
            return .failure("Invalid data or HTTPURLResponse")
        }
        
        if(response.statusCode != 200){
            print(response)
            let errorMessage = response.value(forHTTPHeaderField: "errorMessage") ?? HTTPStatusMessage(statusCode: response.statusCode).get()
            return .failure(errorMessage)
        }
        
        do{
            let response = try JSONDecoder().decode(ResponseType.self,from: data)
            return .success(response)
        }catch{
            return .failure("Invalid URLComponent")
        }
    }
}
