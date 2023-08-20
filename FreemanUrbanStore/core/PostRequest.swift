//
//  PostRequest.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/20/23.
//

import Foundation
import SwiftUI

class PostRequest<DataType : Codable, ResponseType : Codable>{
    let requestUrl : String
    let bindingResponse : Binding<ResponseType?>
    var requestBody : DataType? = nil
    var headers : [String : String]? = nil
    var requestParameters : [String : String]? = nil
    
    init(requestUrl : String, bindingResponse : Binding<ResponseType?>){
        self.requestUrl = requestUrl
        self.bindingResponse = bindingResponse
    }
    
    var urlComponent : URLComponents? = nil
    var request : URLRequest? = nil
    
    func execute() {
        self.urlComponent = URLComponents(string: self.requestUrl)
        if(self.urlComponent == nil) {return}
        self.applyRequestParameters()
        guard let url = urlComponent?.url else {return}
        
        self.request = URLRequest(url: url)
        self.request?.httpMethod = "POST"
        self.applyHeaders()
        self.applyRequestBody()
        self.performTask()
    }
    
    func performTask(){
        if(self.request == nil){return}
        let task = URLSession.shared.dataTask(with: self.request!){data, urlResponse, error in
            guard let data = data, error == nil else {return}
            do {
                let response = try JSONDecoder().decode(ResponseType.self, from: data)
                self.bindingResponse.wrappedValue = response
                print(response)
            } catch {
                print("Response error")
            }
        }
        task.resume()
    }
    
    func applyRequestBody(){
        do{
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
    
    //    Builders
    func setRequestBody(requestBody : DataType) -> PostRequest<DataType, ResponseType>{
        self.requestBody = requestBody
        return self
    }
    
    func setHeaders(headers : [String : String]) -> PostRequest<DataType, ResponseType>{
        self.headers = headers
        return self
    }
    
    func setRequestParams(requestParams : [String : String]) -> PostRequest<DataType, ResponseType>{
        self.requestParameters = requestParams
        return self
    }
}
