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
    
    var body: some View {
        NavigationStack{
            
            VStack{
                
                Spacer()
                
                customView.logoImage
                    .padding(.all)
                
                customView.inputTextField(title: "Username", bindingString: $userEmailField)
                
                customView.inputSecureField(title: "Password", bindingString: $userPasswordField)
                
                customView.darkFilledButton(action: {}, label: {
                    Text("Login".uppercased())
                })
                
                NavigationLink(destination: RegistrationView.getInstance(), label: {
                    Text("Forgot Password?")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(CustomColors.primary)
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                })
                
                Spacer()
                
                
                NavigationLink(destination: RegistrationView.getInstance(), label: {
                    customView.darkOutlinedButton(action: {
                        navigateRegistrationView = true
                    }, label: {
                        Text("Create new account")
                    })
                })
                
                
            }.padding(16)
        }
        .navigationDestination(isPresented: $navigateRegistrationView, destination: {
            RegistrationView.getInstance()
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
