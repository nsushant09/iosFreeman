//
//  LoginView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/15/23.
//

import SwiftUI

struct LoginView: View {
    
    private let customView = CustomViews.instance
    @State var userEmailField : String = ""
    @State var userPasswordField : String = ""
    
    @State var navigateRegistrationView  = false
    @State var navigateOTPView = false
    @State var otpView : OTPView?
    
    @State var errorMessage = ""
    
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack{
            
            Navigator.navigate(
                bindingBoolean: $navigateRegistrationView,
                destination: RegistrationView.getInstance()
            )
            
            Navigator.navigate(
                bindingBoolean: $navigateOTPView,
                destination: otpView
            )
            
            
            VStack{
                Spacer()
                
                customView.logoImage
                    .padding(.all)
                
                customView.inputTextField(title: "Username", bindingString: $userEmailField)
                
                customView.inputSecureField(title: "Password", bindingString: $userPasswordField)
                
                if !errorMessage.isEmpty{
                    customView.errorMessage(self.errorMessage)
                }
                
                customView.darkFilledButton(action: {
                    Task{
                        if await loginViewModel.loginUser(
                            email:userEmailField,
                            password:userPasswordField
                        ){
                            if(loginViewModel.user != nil){
                                otpView = OTPView(
                                    authenticationKey: loginViewModel.authenticationKey,
                                    user: loginViewModel.user!
                                )
                                navigateOTPView = true
                                errorMessage = "Could not proceed please try again."
                            }
                        }
                    }
                }, label: {
                    Text("Login")
                })
                
                NavigationLink(destination: ForgotPasswordEmailView(), label: {
                    Text("Forgot Password?")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(CustomColors.primary)
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                })
                
                Spacer()
                
                
                customView.darkOutlinedButton(action: {
                    navigateRegistrationView = true
                }, label: {
                    Text("Create new account")
                        .frame(maxWidth: .infinity)
                })
                
                
            }
            .padding(16)
        }
        .onReceive(loginViewModel.$errorMessage, perform: {errorMessage in
            self.errorMessage = errorMessage
        })
        .navigationBarBackButtonHidden(true)
    }
    
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }
    
    static private var instance : LoginView? = nil
    static func getInstance() -> LoginView{
        if(LoginView.instance == nil){
            LoginView.instance = LoginView()
        }
        return LoginView.instance!
    }
}
