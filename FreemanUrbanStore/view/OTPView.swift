//
//  OTPView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import SwiftUI

struct OTPView: View {
    
    let authenticationKey : String
    let user : User
    private let customView : CustomViews = CustomViews.instance
    
    @State var otpValue : String = ""
    @State var invalidAttempt = false
    @State var navigateMainView = false
    
    var body: some View {
        NavigationStack{
            
            Navigator.navigate(bindingBoolean: $navigateMainView, destination: MainView())
                .isDetailLink(false)
            
            VStack{
                Spacer()
                
                Image("LogoDark")
                    .resizable()
                    .scaledToFit()
                    .padding(.all)
                
                Text("OTP has been sent to your email")
                    .frame(maxWidth: .infinity, alignment:.leading)
                    .font(.system(.body, design: .rounded))
                    .padding(.leading)
                
                customView.inputTextField(title: "OTP", bindingString: $otpValue)
                
                if invalidAttempt {
                    customView.errorMessage("Invalid One Time Password")
                }
                
                customView.darkFilledButton(action: {
                    invalidAttempt = authenticationKey != otpValue
                    if(authenticationKey == otpValue){
                        navigateMainView = setLoggedInDetails()
                    }
                }, label: {
                    Text("Verify")
                        .frame(maxWidth: .infinity)
                })
                
                Spacer()
            }
            .padding(.all)
        }
    }
    
    func setLoggedInDetails() -> Bool{
        UserDefaults.standard.setValue(
            true,
            forKey: Constants.AS_IS_LOGGED_IN
        )
        do{
            let userJSON = try JSONEncoder().encode(user)
            UserDefaults.standard.setValue(userJSON, forKey: Constants.AS_LOGGED_IN_USER)
            return true
        }catch{
            return false
        }
    }
    
}
