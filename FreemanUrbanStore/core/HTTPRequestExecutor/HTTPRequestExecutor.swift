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
    
    var httpMethod : String = "GET"
    var requestBody : DataType? = nil
    var headers : [String : String]? = nil
    var requestParameters : [String : String]? = nil
    
    private init(requestUrl : String){
        self.requestUrl = requestUrl
    }
    
    var urlComponent : URLComponents? = nil
    var request : URLRequest? = nil
    
    func execute(completion: @escaping (ResponseType?, Error?) -> Void){
        self.urlComponent = URLComponents(string: self.requestUrl)
        if(self.urlComponent == nil) {return}
        self.applyRequestParameters()
        guard let url = urlComponent?.url else {return}
        
        self.request = URLRequest(url: url)
        self.request?.httpMethod = self.httpMethod
        
        self.applyHeaders()
        self.applyRequestBody()
        self.performTask(completion : completion)
    }
    
    func performTask(completion: @escaping (ResponseType?, Error?) -> Void){
        if(self.request == nil){return}
        let task = URLSession.shared.dataTask(with: self.request!){data, urlResponse, error in
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
    
    func applyRequestBody(){
        do{
            if(self.requestBody == nil){return}

            let jsonData = try JSONEncoder().encode(self.requestBody)
            self.request?.httpBody = jsonData
        }catch{
            print(error)
        }
    }
    
    func applyHeaders(){
        self.request?.addValue("application/json", forHTTPHeaderField: "Content-Type")
        headers?.forEach({key, value in
            request?.addValue(value, forHTTPHeaderField: key)
        })
    }
    
    func applyRequestParameters(){
        var requestParams = [URLQueryItem]()
        requestParameters?.forEach({key, value in
            requestParams.append(URLQueryItem(name : key, value: value))
        })
        self.urlComponent?.queryItems = requestParams
    }
    
    class Builder {
        private var requestUrl: String? = nil
        private var requestBody: DataType? = nil
        private var headers: [String: String]? = nil
        private var requestParameters: [String: String]? = nil
        private var httpMethod: String = "GET"
        
        func setRequestUrl(_ url: String) -> Builder {
            self.requestUrl = url
            return self
        }
        
        func setRequestBody(_ requestBody: DataType) -> Builder {
            self.requestBody = requestBody
            return self
        }
        
        func setHeaders(_ headers: [String: String]) -> Builder {
            self.headers = headers
            return self
        }
        
        func setRequestParams(_ requestParams: [String: String]) -> Builder {
            self.requestParameters = requestParams
            return self
        }
        
        func setHttpMethod(_ httpMethod: HTTPMethods) -> Builder {
            self.httpMethod = httpMethod.rawValue
            return self
        }
        
        func build() -> HTTPRequestExecutor<DataType, ResponseType> {
            
            guard let requestUrl = requestUrl else{
                fatalError("URL is required.Use .setRequestUrl() to insert the URL.")
            }
            
            let executor = HTTPRequestExecutor<DataType, ResponseType>(
                requestUrl: requestUrl
            )
            
            executor.headers = headers
            executor.httpMethod = httpMethod
            executor.requestBody = requestBody
            executor.requestParameters = requestParameters
            
            return executor
        }
    }
}
