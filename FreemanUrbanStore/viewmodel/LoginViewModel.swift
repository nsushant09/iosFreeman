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
    @Published var navigateToOTP = false
    
    func loginUser(email : String, password : String) async{
        let userResult = await HTTPRequestExecutor<User, User>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/user/by_user_detail")
            .setRequestParams([
                "email" : email,
                "password" : password
            ])
            .build()
            .executeAsync()
        
        let errorResponse = ResultManager.extractFailureValue(from: userResult)
        let userResponse = ResultManager.extractSuccessValue(from: userResult)
        
        if let userResponse = userResponse{
            DispatchQueue.main.async {[weak self] in
                self?.user = userResponse
                self?.errorMessage = errorResponse
            }
            await sendOTPEmail(userResponse: userResponse)
        }
        
    }
    
    func sendOTPEmail(userResponse : User) async {
        guard let userEmail = userResponse.email else{return}
        if let authenticationResponse = await EmailManager().mailOTPPassword(email: userEmail) {
            DispatchQueue.main.async {[weak self] in
                self?.authenticationKey = authenticationResponse
                self?.navigateToOTP = authenticationResponse != "-1"
            }
        }
    }
    
    
    func getUser() -> User{
        return user!
    }
    
}
