//
//  EmailManager.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/21/23.
//

import Foundation

struct EmailManager{
    
    func mailOTPPassword(email : String) async -> String?{
        let result = await HTTPRequestExecutor<String, [String : String]>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/mailOtp")
            .setRequestParams([
                "email" : email
            ])
            .build()
            .executeAsync()
        
        guard let response = ResultManager.extractSuccessValue(from: result) else {
            return "-1"
        }
        
        return response["authenticationKey"]  ?? "-1"
    }
    
}
