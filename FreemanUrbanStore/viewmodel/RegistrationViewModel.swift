//
//  RegistrationViewModel.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/16/23.
//

import Foundation
import SwiftUI

class RegistrationViewModel : ObservableObject{
    
    @Published var authenticationKey = "-1"
    @Published var errorMessage = ""
    @Published var navigateToOtpPage = false
    @Published var userDetail : User?
    
    func registerUser(user : User) async{
        
        if(!UserValidator(user: user).validate()){
            DispatchQueue.main.async {[weak self] in
                self?.errorMessage = "Not a valid user details"
            }
            return
        }
        
        let userResult = await HTTPRequestExecutor<User, User>
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
            return
        }
        
        if(userResponse.email != nil){
            let authenticationResponse  = await EmailManager().mailOTPPassword(email: userResponse.email!)
            if(!authenticationResponse.isEmpty){
                DispatchQueue.main.async {[weak self] in
                    self?.authenticationKey = authenticationResponse
                    self?.userDetail = userResponse
                    self?.navigateToOtpPage = self?.authenticationKey != "-1"
                }
            }
        }
        
    }
}
