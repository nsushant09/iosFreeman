//
//  RequestBodyProcessor.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 9/2/23.
//

import Foundation

struct RequestBodyProcessor<T : Codable>{
    let request : URLRequest?
    let requestBody : T
    
    func apply(){
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
}
