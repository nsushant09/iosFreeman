//
//  RegistrationViewModel.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/16/23.
//

import Foundation
import SwiftUI

class RegistrationViewModel : ObservableObject{
    
    @Published var createAccountText = "Create Account"
    @Published var authenticationKey = "-1"
    @Published var errorMessage = ""
    @Published var navigateToOtpPage = false
    @Published var userDetail : User?
    
    func registerUser(user : User) async{
        
        createAccountText = "Creating..."
        
        let userResult = await HTTPRequestExecutor<User>
            .Builder()
            .setRequestUrl(Constants.BASE_URL + "/user/")
            .setRequestBody(user)
            .setHttpMethod(HTTPMethods.POST)
            .build()
            .executeAsync()
        
        let errorResponse = ResultManager.extractFailureValue(from: userResult)
        guard let userResponse = ResultManager.extractSuccessValue(from: userResult) else {
            DispatchQueue.main.async {[weak self] in
                self?.errorMessage = errorResponse
            }
            createAccountText = "Could not create account"
            return
        }
        
        if(userResponse.email != nil){
            if let authenticationResponse  = await EmailManager().mailOTPPassword(email: userResponse.email!){
                DispatchQueue.main.async {
                    DispatchQueue.main.async {[weak self] in
                        self?.createAccountText = "Created"
                        self?.authenticationKey = authenticationResponse
                        self?.userDetail = userResponse
                        self?.navigateToOtpPage = self?.authenticationKey != "-1"
                    }
                }
            }
        }
        
    }
}
