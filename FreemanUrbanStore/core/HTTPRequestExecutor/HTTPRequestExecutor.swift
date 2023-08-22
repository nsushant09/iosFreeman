//
//  HTTPRequestExecutor.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/20/23.
//

import Foundation
import SwiftUI

class HTTPRequestExecutor<DataType : Codable, ResponseType : Codable>{
    
    let requestUrl : String
    
    var httpMethod : HTTPMethods = .GET
    var requestBody : DataType? = nil
    var headers : [String : String]? = nil
    var requestParameters : [String : String]? = nil
    
    private init(mRequestUrl : String){
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
                let response = try JSONDecoder().decode(ResponseType.self, from: data)
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
            let taskPerformer = TaskPerformerFactory<ResponseType>.getTaskPerformer(httpMethod: httpMethod, request: request!)
            return try await taskPerformer.performTaskAsync()
        }catch{
            return .failure("Could not perform network call")
        }
    }
    
    func applyRequestBody(){
        do{
            if(requestBody == nil){return}
            
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
        request?.addValue("application/json", forHTTPHeaderField: "Content-Type")
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
    
    class Builder {
        private var mRequestUrl: String? = nil
        private var mRequestBody: DataType? = nil
        private var mHeaders: [String: String]? = nil
        private var mRequestParameters: [String: String]? = nil
        private var mHttpMethod: HTTPMethods = .GET
        
        func setRequestUrl(_ url: String) -> Builder {
            self.mRequestUrl = url
            return self
        }
        
        func setRequestBody(_ requestBody: DataType) -> Builder {
            self.mRequestBody = requestBody
            return self
        }
        
        func setHeaders(_ headers: [String: String]) -> Builder {
            self.mHeaders = headers
            return self
        }
        
        func setRequestParams(_ requestParams: [String: String]) -> Builder {
            self.mRequestParameters = requestParams
            return self
        }
        
        func setHttpMethod(_ httpMethod: HTTPMethods) -> Builder {
            self.mHttpMethod = httpMethod
            return self
        }
        
        func build() -> HTTPRequestExecutor<DataType, ResponseType> {
            
            guard let requestUrl = mRequestUrl else{
                fatalError("URL is required.Use .setRequestUrl() to insert the URL.")
            }
            
            let executor = HTTPRequestExecutor<DataType, ResponseType>(
                mRequestUrl: requestUrl
            )
            
            executor.headers = self.mHeaders
            executor.httpMethod = self.mHttpMethod
            executor.requestBody = self.mRequestBody
            executor.requestParameters = self.mRequestParameters
            
            return executor
        }
    }
}
