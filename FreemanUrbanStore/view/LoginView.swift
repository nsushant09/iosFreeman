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
    
    var body: some View {
        NavigationView{
            VStack{
                
                Spacer()
                
                customView.logoImage
                    .padding(.all)
                
                customView.inputTextField(title: "Username", bindingString: $userEmailField)
                
                customView.inputSecureField(title: "Password", bindingString: $userPasswordField)
                
                customView.darkFilledButton(action: {}, label: {
                    Text("Login".uppercased())
                })
                
                Text("Forgot Password?")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(CustomColors.primary)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                
                
                Spacer()
                
                customView.darkOutlinedButton(action: {}, label: {
                    Text("Create new account")
                })
                
                
            }.padding(16)
        }
    }
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }
}
