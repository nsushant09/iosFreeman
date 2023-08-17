//
//  ForgotPasswordNewPassView.swift
//  FreemanUrbanStore
//
//  Created by SushantNeupane on 8/17/23.
//

import SwiftUI

struct ForgotPasswordNewPassView: View {
    
    private let customView = CustomViews.instance
    
    @State var newPassword : String = ""
    @State var reNewPassword : String = ""
    
    @State var navigateOTPView = false
    
    var body: some View {
        NavigationStack{
            VStack{
                
                Navigator.navigate(
                    bindingBoolean: $navigateOTPView,
                    destination: OTPView()
                )
                
                Spacer()
                
                Text("Freeman Urban Store,\nPassword Reset")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 28, weight: .semibold, design: .monospaced))
                
                Text("Enter new password")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(.body,design: .rounded))
                    .padding(.top)
                
                customView.inputSecureField(title: "New Password", bindingString: $newPassword)
                customView.inputSecureField(title: "Re-New Password", bindingString: $reNewPassword)
                customView.darkFilledButton(action: {
                    navigateOTPView = true
                }, label: {
                    Text("Confirm")
                        .frame(maxWidth: .infinity)
                })
                
                
                Spacer()
            }.padding(.all)
        }
    }
}


struct ForgotPasswordNewPassView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordNewPassView()
    }
}
