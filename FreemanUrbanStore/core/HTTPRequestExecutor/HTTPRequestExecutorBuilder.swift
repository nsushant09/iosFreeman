//
//  HTTPRequestExecutorBuilder.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 9/2/23.
//

import Foundation

extension HTTPRequestExecutor{
    class Builder {
        private var requestUrl: String? = nil
        private var requestBody: DataType? = nil
        private var headers: [String: String]? = nil
        private var requestParameters: [String: String]? = nil
        private var httpMethod: HTTPMethods = .GET
        private var contentType : String? = nil
        
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
            self.httpMethod = httpMethod
            return self
        }
        
        func setContentType(_ contentType : String) -> Builder{
            self.contentType = contentType
            return self
        }
        
        func build() -> HTTPRequestExecutor<DataType, ResponseType> {
            
            guard let requestUrl = requestUrl else{
                fatalError("URL is required.Use .setRequestUrl() to insert the URL.")
            }
            
            let executor = HTTPRequestExecutor<DataType, ResponseType>(
                mRequestUrl: requestUrl
            )
            
            executor.headers = self.headers
            executor.httpMethod = self.httpMethod
            executor.contentType = self.contentType
            executor.requestBody = self.requestBody
            executor.requestParameters = self.requestParameters
            
            return executor
        }
    }
}
