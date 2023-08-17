//
//  ForgotPasswordEmailView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import SwiftUI

struct ForgotPasswordEmailView: View {
    
    private let customView = CustomViews.instance
    
    @State var userEmail : String = ""
    
    @State var navigateFPPassView = false
    
    var body: some View {
        NavigationStack{
            
            Navigator.navigate(
                bindingBoolean: $navigateFPPassView,
                destination: ForgotPasswordNewPassView()
            )
            
            VStack{
                
                Spacer()
                
                Text("Freeman Urban Store,\nPassword Reset")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 28, weight: .semibold, design: .monospaced))
                
                Text("Please enter your email address")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(.body,design: .rounded))
                    .padding(.top)
                
                customView.inputTextField(title: "Email", bindingString: $userEmail)
                customView.darkFilledButton(action: {
                    //TODO : Verify if email exist
                    navigateFPPassView = true
                }, label: {
                    Text("Verify")
                        .frame(maxWidth: .infinity)
                })
                
                
                Spacer()
            }.padding(.all)
        }
    }
}

struct ForgotPasswordEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordEmailView()
    }
}
