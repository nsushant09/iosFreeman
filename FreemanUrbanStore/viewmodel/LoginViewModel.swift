//
//  LoginViewModel.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/16/23.
//

import Foundation
import SwiftUI

class LoginViewModel : ObservableObject{
    
    @Published var user : User? = nil
    @Published var errorMessage = ""
    @Published var authenticationKey = "-1"
    
    func loginUser(email : String, password : String) async -> Bool{
        let result = await HTTPRequestExecutor<User, User>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/user/by_user_detail")
            .setRequestParams([
                "email" : email,
                "password" : password
            ])
            .build()
            .executeAsync()
        
        DispatchQueue.main.async {[weak self] in
            self?.user = ResultManager.extractSuccessValue(from: result)
            self?.errorMessage = ResultManager.extractFailureValue(from: result)
        }
        
        if(user?.email != nil){
            authenticationKey = await EmailManager().mailOTPPassword(email: user!.email!)
            return authenticationKey != "-1";
        }
        return false;
    }
    
    func getUser() -> User{
        return user!
    }
    
}
