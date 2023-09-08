//
//  HTTPRequestExecutor.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/20/23.
//

import Foundation
import SwiftUI

class HTTPRequestExecutor<ResponseType : Codable>{
    
    let requestUrl : String
    
    var httpMethod : HTTPMethods = .GET
    var requestBody : Codable? = nil
    var headers : [String : String]? = nil
    var requestParameters : [String : String]? = nil
    var contentType : String? = nil
    
    internal init(mRequestUrl : String){
        requestUrl = mRequestUrl
    }
    
    var urlComponent : URLComponents? = nil
    var request : URLRequest? = nil
    
    
    func execute(completion: @escaping (ResponseType?, Error?) -> Void){
        urlComponent = URLComponents(string: requestUrl)
        if(urlComponent == nil) {return}
        applyRequestParameters()
        guard let url = urlComponent?.url else {return}

        request = URLRequest(url: url)
        request?.httpMethod = httpMethod.rawValue

        applyHeaders()
        applyRequestBody()
        performTask(completion : completion)
    }

    func performTask(completion: @escaping (ResponseType?, Error?) -> Void){
        if(request == nil){return}
        let task = URLSession.shared.dataTask(with: request!){data, urlResponse, error in
            guard let data = data, error == nil else {return}
            do {
                let response = try JSONDecoder()
                    .decode(ResponseType.self, from: data)
                completion(response, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func executeAsync() async -> Result<ResponseType>{
        urlComponent = URLComponents(string: requestUrl)
        if(urlComponent == nil) {
            return .failure("Invalid URLComponent")
        }
        applyRequestParameters()
        guard let url = urlComponent?.url else {
            return .failure("Invalid URL")
        }
        
        request = URLRequest(url: url)
        request?.httpMethod = httpMethod.rawValue
        
        applyHeaders()
        applyRequestBody()
        
        do{
            let taskPerformer = TaskPerformerFactory<ResponseType>
                .getTaskPerformer(
                    httpMethod: httpMethod,
                    request: request!
                )
            return try await taskPerformer.performTaskAsync()
        }catch{
            return .failure("Could not perform network call")
        }
    }
    
    func applyRequestBody(){
        do{
            guard let requestBody = requestBody else {return} 
            let jsonData = try JSONEncoder().encode(requestBody)
            
            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                if let prettyPrintedData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]){
                    request?.httpBody = prettyPrintedData
                }
            }
            
        }catch{
            print(error)
        }
    }
    
    func applyHeaders(){
        
        if let contentType = contentType{
            request?.addValue(contentType, forHTTPHeaderField: "Content-Type")
        } else {
            request?.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        headers?.forEach({key, value in
            request?.addValue(value, forHTTPHeaderField: key)
        })
    }
    
    func applyRequestParameters(){
        var requestParams = [URLQueryItem]()
        requestParameters?.forEach({key, value in
            requestParams.append(URLQueryItem(name : key, value: value))
        })
        urlComponent?.queryItems = requestParams
    }
}
